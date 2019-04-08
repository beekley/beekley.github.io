Hi, my name is Brett Beekley. I'm a software engineer at Science 37. And I hate our Authorization service.

I focus mainly on the backend of our platform-- its data, its API, and especially the services that power them. I treat the services like they are my children. I love them. I'm proud of them. I nurture and let them grow. And as a parent must, I don't have favorites. Except the Authorization service. I hate our Authorization service.

### Background

Before we get into why Authorization is a no good, bad service, let's talk about how we got there. I spoke with our historians and they found records from before that service. It's the ancient year of 2017. We had one service that handled everything (a "monolith", ick!). It took every request. It owned all of our data. Like many things, authorization was simple:

1. A user would log into the monolith and get a token for their session
2. The user would make a request with the token
3. The monolith would query its data for the account and roles associated with the token
4. The monolith would query its data for the relationship between that account/roles and the data being requested
5. The monolith would deny the request, or allow it to continue

Then it was 2018, "monolith" became a bad word, and we were jealous of the cool kids and their microservices. We were also growing as a tech shop (see [Conway's Law](https://en.wikipedia.org/wiki/Conway%27s_law)) and migrating from move-fast startup-mode code to systems we'd be proud and happy to maintain for years (see [Wizarding vs Engineering](https://www.tedinski.com/2018/03/20/wizarding-vs-engineering.html)). A service-oriented architecture wasn't required to do those things, but it was what we chose.

With distributed services, distributed APIs and distrubuted data, comes a need for federated authorization and authentication. The old monolith would still handle authentication since it owned user's account data. Since our platform was growing, we wanted to adopt a model that maps a user to their roles, which each have a set of permissions, which each have a set of actions that permission allows the user to do. The `role` -> `permission` -> `action` data didn't previously exist, so it had no owner yet, so we built an Authorization service around it.

And thus our problems began.

### Big queries for small data

First, we decided to use a very normalized model to store that data and the relations between them. The only query the service would make (get the actions for a user's roles) performed a bunch of joins just to query tables that had, at most, dozens of rows in them.

### Painful update process

Next, we had no upsert API, so the only way to get/update Authorization data was to write [`db-migrate`](https://www.npmjs.com/package/db-migrate) scripts. These were SQL queries for how to make/revert the update and, since the data was distributed across several tables, they looked like this:

```
# Create activities
INSERT INTO Activity (`method`, `url`) VALUES ('post', '/some endpoint');
SET @aid1 = LAST_INSERT_ID();
INSERT INTO Activity (`method`, `url`) VALUES ('patch', '/another endpoint');
SET @aid2 = LAST_INSERT_ID();
INSERT INTO Activity (`method`, `url`) VALUES ('get', '/yet one more endpoint');
SET @aid3 = LAST_INSERT_ID();

# Create permissions
INSERT INTO Permission (`name`) VALUES ('some permission');
SET @pid1 = LAST_INSERT_ID();
INSERT INTO Permission (`name`) VALUES ('another permission');
SET @pid2 = LAST_INSERT_ID();

# Create mapping between permissions-activities. Use the IDs from the previous insert statements here.
INSERT INTO PermissionActivity (`permissionId`, `activityId`, `scope`) VALUES
 (@pid1, @aid1, 'global')
,(@pid1, @aid2, 'global')
,(@pid1, @aid3, 'global')

,(@pid2, @aid1, 'trial')
,(@pid2, @aid2, 'trial')
,(@pid2, @aid3, 'trial');

# Create mapping between roles-permissions. Use the IDs from the previous insert statements here.
INSERT INTO RolePermission (`roleId`, `permissionId`) VALUES
 ('1', @pid1)

,('2', @pid2)
,('3', @pid2)
,('10', @pid2)
,('11', @pid2);
```

Incomprehsenible. To code reviewers, to product managers who define the access controle rules, to even the author 5 minutes after writing it. Also there's a similar `down` script that reverts it. Hope you got all of those relations right in both!

### Complicated infrastructure

Finally, it is its own service + DB. That's more infrastructure to deploy, maintain, troubleshoot. Fortunately, our deployments are pretty automated so it's not *too much* work. But we've had nonzero problems related to deployment, especially to developers/testers own environments. We should have zero for something that serves a few kb of static data. 

### Conclusion

Really it all comes down to overengineering a solution without identifying the real problem and its scope. It's easy to say the problem is "We need a service to manage Authorization data", when we should have said "Our distributed services need to know the subset of the <100 total actions that a requestor has".

If I were to build it again, I'd set up some very light service like a lambra or even Redis to serve the `role` -> `permission` -> `action` data, which is loaded into memory from a simple JSON that could even be written (or at least understood) by any member of the tech team. We'll probably build that, but in the meantime the Authorization service works. Even if I don't like it.

(note: the negative energy of this article is all for fun. I love my child Authorization service and all who helped make it.)
