This summer, the CA state legislature voted on a number of bills to address the state’s housing shortage, including SB 1120, which would have legalized duplexes on most residential lots and fourplexes on some (it passed, but [too late](https://www.latimes.com/homeless-housing/story/2020-09-01/california-assembly-sb-1120-duplexes) to reach the governor).

I [recently wrote about](https://blog.beekley.xyz/Building-density-without-building-up/) how building a relatively small number of fourplexes could have a large impact on the housing deficit. That post proposes that the rarity of fourplexes means it wouldn’t impact a neighborhood’s character. My neighborhood has many ~fourplexes that blend in by looking similar to their surrounding single-family homes. I hypothesize that **many <=4 unit buildings are actually the same size as many single family homes**, thus fit in with the neighborhood character.

## Results

The following graph shows the normalized distribution of building size for low-density buildings in LA county, grouped by their number of units. The peaks represent the most common building size with that number of units. The data is normalized, meaning the curves are stretched to have the same height. Single family homes are by far more common, so this was needed to make the curves comparable. A consequence is the fourplex curve is noisy since there are many fewer buildings to make up the curve.

These curves have significant overlap, meaning there are many existing fourplexes that are the same size as many single-family homes. Most fourplexes are larger than most homes, which makes sense since there are four times as many units in the building. There is even more overlap between single-family and duplex buildings, with duplexes being about a third larger.

![1](https://github.com/beekley/beekley.github.io/blob/master/images/size1.png?raw=true)

For comparison, the graph below adds data for medium density (LA zone R3, or 5-25 unit buildings) and high density (LA zone R4/5, or 25+ unit buildings). There are a few medium density buildings that are the same size as single family homes -- think a set of bungalows and a Palisades mansion -- most are significantly larger. They are much closer than the high density towers, which don’t even share much overlap with the medium density buildings.

![2](https://github.com/beekley/beekley.github.io/blob/master/images/size2.png?raw=true)

## Conclusions

Duplexes, triplexes, and even fourplexes can fit into single family neighborhoods due to their similar possible size. Of course there are large fourplexes out there, but the data show that it's possible to allow multi-family buildings without compromizing character with respect to building size. (And the power of zoning can be used to enforce those size limits).

This fits into my experience-- e.g. my neighborhood has a few multi-family buildings (particularly SFHs with [ADU](https://www.hcd.ca.gov/policy-research/accessorydwellingunits.shtml)s) that look like single family homes from the street and I’d only know the difference because I am interested in these things and look it up. This is a reason fourplexes are still considered “low density”.

The data also show how 5-25 unit buildings are the [missing middle](https://missingmiddlehousing.com/) density. There is a lot of understandable fear of towers coming in and changing an area, but middle density is far from the size and density of towers, while providing much needed housing and walkability to an area.

## Future Work

Buliding size is far from the only factor in how a building fits into a neighborhood. Objectively, the size of a building relative to its lot size is a measure of density and could be used to see if multi-family buildings are a significant change in neighborhood’s density. There are also subjective factors (e.g. design aesthetics, greenery, age), and economic impacts (e.g. gentrification and displacement of families) of development, which can be hard to model. The housing bills try to address those points, but I believe the uncertainty of how they might adversely affect people’s homes and neighborhoods have prevented the larger bills from passing.
