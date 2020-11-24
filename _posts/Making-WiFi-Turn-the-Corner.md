I recently moved to a larger apartment to get a dedicated WFH office and have more space for [our cats](https://www.instagram.com/colin_and_monet/). However, I quickly started having internet issues with devices in the new office room. Amazingly, the first signal was an automated email from the company IT saying the fleet management software on my laptop detected a poor wireless signal and provided a guide for how to improve. I didn't read into it until I started getting consistent video call drops, game disconnects, and download speeds 1/10th of what I used to.

Before experimenting, I wanted to establish a measurable baseline. Download speeds were too variable (1 mbps sometimes, 100 others). So I chose signal strength ([RSSI](https://www.metageek.com/training/resources/understanding-rssi.html)). On my Mac, it's visible by holding option and clicking the wifi menubar icon. On my desktop PC, I used [InSSIDer](https://www.metageek.com/products/inssider/). On my phone, I downloaded an app, but it's also available in some developer setting.

I measured about -72±2 db at my desk. Not good.

The first thing I tried was picking a different broadcast channel on the router. I don't live in a particularly large building, so nothing was too crowded and I didn't see any difference in RSSI.

Next I tried moving the router around the living room. The desk is about 20 ft and around a corner from the router. I could cut 5 ft off by repositioning the router. No differennce, which surprised me since I thought the distance would matter.

A friend had a spare [AC3200 router](https://www.amazon.com/R8000-100NAS-Nighthawk-Tri-Band-Ethernet-Compatible/dp/B00KWHMR6G). I set that up in place of the ISP-provided one, which is of dubious quality. No difference.

Then I started to make a map of RSSI around my apartment to see if there were any weird artifacts. The living room was in the -40s db. The hall and doorway to the office was -50s db. But as soon as you turned into the office to face my desk, it went to -70 db. The doorway had line-of-sight to the router, while everywhere else in the room got poor signal.

Now I knew if I could get line-of-sight, the signal strenght would be improved. My desktop had an external antenna, so I could buy some [more coax cable](https://www.amazon.com/gp/product/B07842ZX63/) to place that in the hallway. But that wouldn't help my work laptop. (I actually did this first since games are the priority, but bought the wrong cable and moved onto a general solution 😭)

A lot of folk on the internet said they solved similar issues by using a mesh network. I didn't really want to spend more money since I had two routers already! I set up the ISP-provided on in my office and poked around the settings. No option to join an existing network or any sort of bridge/mesh mode. I looked through the Nighthawk router settings (and docs), but no luck either.

The Nighthawk router has two 5 Ghz radios. There had to be a way to get one to join a network and the other to broadcast one. I flashed the open source firmware [Open WRT](https://openwrt.org/toh/netgear/r8000) (super easy!) and found a guide for setting up [bridge mode](https://www.nerd-quickies.net/2017/04/03/setup-lanwlan-bridge-with-openwrt-luci/) (lots of steps, but it worked on the first try!). I placed the 2nd, bridge router within line-of-sight to both the main router and my desk. All devices got in the -50s db RSSI! And the success was reflected in practical speed tests and game pings.

This was a fun project to learn a bit more about about radio waves propagate in an apartment and how to configure a network.
