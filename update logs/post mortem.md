# bugTDX: post-mortem

As of writing this, bugTDX was a commercial failure. The game cost $237 AUD to make and it pulled in about $100. In all honesty, I was surprised with this, but in hindsight, it's a completely reasonable result due to a few factors.

## pre-launch

### metrics

The most interesting part about writing up this post-mortem for me is getting into the analytics. Here's the wishlist data from when I put the game on Steam, to just before launch. 

[![Wishlist Data](https://i.postimg.cc/8CgY7qL8/Screenshot-98.png)](https://postimg.cc/68zcSbHz)

64 is objectively bad. Wishlist conversion rates are far lower than you'd expect - typically around 1-3%. From this, I was lucky to even get one conversion. I am curious to see how long it would've stayed consistently increasing for. Although it was only an average of 1 a day, I wonder if I'd left the page up for a year, that would've meant 365 wishlists, or more, or less. It fluctuated far more than I expected, considering the only times I promoted the Steam page was when I first put it up. 

But why was the wishlist count so abysmal? Likely due to the page itself, in particular the screenshots and the trailer. The problem with the trailer, is that it simply jumped around too much. I recorded it with the camera turned on, which is enjoyable in gameplay, but not so much when footage is put at 4x speed. I got a few comments saying stuff like 'is the trailer supposed to be glitching around like that?' and 'can I turn off the camera in-game?'. Additionally, the aspect ratio of the trailer lined up with my computer which has an irregular resolution of 2256x1504 (which also made it a hassle to get the dimensions right for regular displays). Same with the screenshots. Although no one *commented* on the resolution, it just looks unprofessional and lazy to not amend it - which it was. 

Another problem with the screenshots is that they weren't actually up to date, and still aren't (and will likely never be). Getting screenshots and then scaling them according to the desired resolution is finnicky to do on my computer, so I simply used screenshots I'd taken during development. I don't think it's noticeable to potential players though - the main problem was the aspect ratio.

The page also suffered from an identity crisis - people struggled to understand the unique mechanic, especially when they were unfamiliar with the auto-chess genre. The 'gimmick' of the game was that you had to cycle through the shop to find the towers you liked, rather than have all towers available from the side bar as in BTD6. I also had more towers than BTD6 (excluding their heroes), which was a selling point that I could've emphasised more. 

Overall, pretty pathetic stats, but not surprising. I really believe that if the page looked better, the natural advertising from Steam would've been enough to snowball it into a few more wishlists. Of course, however, the aesthetics limited the success of the store page. Despite it's shortcomings, I've definitely seen worse Steam pages...

Takeaways:

- Prioritise graphics (no one will read the descriptions)
- Highlight the 'gimmick'
- Get the aspect ratio right - probably obvious lol
- Put the page up ASAP

### marketing

Often a game's failure is linked to its poor marketing and this is no different. Completely aware that I was speaking into the void on twitter, yet I made no attempt to diversify other than a few Reddit posts and a message on the Discord. I also ended up sending a few keys to streamers but as of yet no-one has played the game on stream. This is likely because of the release date, which I will discuss more below.

The thing is with marketing - I don't really enjoy it. I was content with the *somewhat* positive reception from the people who did play it, and it's likely my next game won't have much more marketing. The absolute last thing I wanted to do was spend more money on marketing, as since game dev is a side hobby for me, I didn't need the game to be super successful, or even turn a profit, because ultimately, I enjoyed making it. Despite my non-existent marketing, I still expected the game to be successful by being played on a few YouTube channels; notably, [Olexa](https://www.youtube.com/@OlexaYT), [Retromation](https://www.youtube.com/@Retromation), [Wanderbots](https://www.youtube.com/Wanderbots), and more optimistically, [Northenlion](https://www.youtube.com/@Northernlion). I think there is a slim chance that the game may still be covered by some of these, but I'm not very optimistic about that. There's a few reasons why it wasn't played by these guys but I believe it came down to the release date and the aesthetic.

Takeaways:

- Don't expect influencers to play your game, even if it falls in their niche

### release date

The game was released on the 16th of June, 3 days before the Steam Next Fest. I pretty much shot myself in the foot for releasing it this time, because the roguelike market became super over-crowded with free, experimental games that were being actively promoted by Steam. I didn't want to release a demo of the game because I just wanted it to be done with and I didn't know Next Fest was just around the corner. Releasing a demo first would've quickly ironed out some of the peculiar bugs and game crashes that were in the game on launch due to lacklustre efforts to get playtesters. It also meant I would've built more wishlists pre-launch, which is really the only time they're going to convert. 

The YouTubers who might've played the game became instantly overwhelmed with hundreds of other cool roguelikes from the Next Fest, and their attention diverted to finding and playing demos exclusively. The Next Fest is an amazing opportunity for burgeoning developers to get a playerbase and feedback on their game before releasing it and it's genuinely absurd that I didn't take advantage of that. 

Takeaways:

- Release a demo to build a playerbase
- Take advantage of Steam promotion

## launch

### metrics

So there's a couple of metrics that are worth discussing. Most interesting, of course, is the financial aspect, so let's get into that.

[![Sales](https://i.postimg.cc/LJw5HL8f/Screenshot.png)](https://postimg.cc/LJw5HL8f)

Even though I was expecting (and hoping) to break even, I'm actually still relatively happy with release. There's a couple of things that immediately stand out that aren't great, but let's first focus on the positives. Gross revenue of $139 usd is pretty cool. $99 net is also ok, I don't think I can take it out until I get $100 but I'm hoping I can make at least one more sale. That's $99 before Steam's 30% cut, but also before conversion to my local currency. After all that, I come away with about $98 aud. A net profit of -$137. 52 people bought the game, which is kind of hard to believe considering the marketing.

Sales obviously peaked at the start and pretty quickly dropped off. I'll keep monitoring them. Might see a miniscule spike during the Winter Sale when the game goes on sale, but unless a YouTuber covers it, I'm not expecting me to break even unfortunately.

Another positive is the wishlists jumped up on release a fair bit. Although not listed there, the conversion rate was ~1.5% which is probably two sales. More emails on sale is always a good thing, as games can get lost pretty easily in Steam sales as you'd expect. 

Probably the most glaring parts of the stats are the median time played, and the units returned. I was really disappointed with these metrics, because it related directly to the quality of the game. First, let's talk about refunds. 

[![Refund data](https://i.postimg.cc/zvgydtGr/image.png)](https://postimg.cc/bSqYrRnC)

Some of it is a bit bullshit. Frame rate too low and system requirements not met are a bit absurd. The game runs at a consistent 60 fps on a toaster, I presume someone just wanted a refund and chose a random option. 

Not fun (4) was pretty disheartening. None of these users wrote notes about what they didn't enjoy, which would've been pretty helpful. Of course, if they didn't enjoy the game they have every right to refund it. I speculate a bit on this later on when I talk about the game itself, and I've reached the conclusion that the game probably just isn't engaging enough for a significant portion of people. I suspect a lot of people also didn't find the game fun but didn't return it out of pity.

Other issues (2) is completely justified. On launch the game was glitchy and buggy and that was completely preventable. Struggling to find players willing to test, I eventually just said 'fuck it' and released it hoping that Steam players would playtest for me. I did have the foresight to set up a pipedream workflow to a google sheets which reported game crashes to me. Crashes in the game on release are mostly ironed out now, so that's good. 

Game will not start (1). Hmm. Not quite sure if this is a legit refund, because no crashes occured on runtime, they typically occured from an unplanned interaction between towers, or the player doing something unexpected. Either way, this is probably grouped under other issues which would make sense.

Game too difficult (1) was a bit surprising. I think this just came from someone who wasn't willing to invest the time to get good at the game. Fair enough I guess, I definitely could've made the game a little easier to accomodate for these types of players but oh well.

21.2%, almost a quarter, of sales were refunded. Other developers have different refund rates of course, but in comparison to pretty much all sources, this is substantially above average. Most developers are quoting about 5-7%. Pretty disappointing, but lesson learned - make a better game.

[![Playtime stats](https://i.postimg.cc/VL5gwMK0/image.png)](https://postimg.cc/JGVZcyVR)

The 13 people who played it for 1-10 minutes likely either played it for a second and lost interest, or just didn't play it at all. Then we move to 10-20 minutes - this is likely people who played it maybe once or twice and lost a run as wel as interest. It's not an easy game for a beginner and the difficulty spike is too sharp at the beginning and becomes almost impossible later on. 20-70 minutes has about the same amount in each ten minute interval. About 36% of people got the victory achievement which correlates to this little group here, indicating that of the people who did persist after the initial difficulty climb, ended up beating the game. It then falls off substantially with only a few people between 1 hour and 2 hours. 

What's most interesting here is the 200+ minute bracket. I've had two friends play the game for long enough to end up in the 200+ bracket however there's five people in total in that end of the spectrum. It's possible they could've left it idle, but I don't really see that happening because the game doesn't pause automatically in the background. This is actually pretty cool because it does sort of line up with some of the harder achievements in the game, namely VICTORY++++, which is beating the game on the highest difficulty. ~4% of players have this achievement (2 people). Considering I don't know either of these people and hoping they didn't use an achievement hack as if they did they'd probably get all achievements (some achievements have 0% of players), that's pretty cool people enjoyed the game enough to play some of the most difficult and unfair parts for so long!

From this playtime, I can gather that the game just didn't entice most players from the get-go. 

### reviews

All four reviews of the game were positive, which is nice. The game didn't hit the magic 10 reviews number, and I doubt it will. Go and read [the reviews](https://steamcommunity.com/app/2336160/reviews/?browsefilter=toprated&snr=1_5_100010_) and my responses to them for yourself if you're interested - a lot of really helpful info that I'll apply to future projects. A few of them have optimism for the future of bugTDX, which is perhaps a little misguided due to the lack of any indication that I'd work on it further. 

## the game itself

### summary

I think the reviews aptly sum up the positives of bugTDX and there's not much point in reiterating them because this post-mortem isn't supposed to be an advertisment - it's supposed to be an analysis and critique. So let's get into some of the biggest flaws of the game.

### art

What deterred most from the game is the art. It just looks bad. It's not cohesive or consistent. On top of that, the pixellated look worked on some towers quite well to hide lazy design (I quite like the ritual tower), but it made a lot of the bugs look really odd. The slugs in particular didn't have a thick enough outline so they'd often just look like little green turds moving along the track. 

### balancing

The difficulty curve for the game is kind of a squiggly line that jumps up and falls down every time new towers enter the shop which makes it confusing for players to identify which towers are good and which aren't. On top of that, despite having stats available to the player, they didn't equate to DPS because the way firerate was calculated was confusing. A player having those stats available might be interesting for them, but it didn't really end up being as helpful as I'd hoped because no one could be fucked actually interpreting what those random numbers actually meant. Stats should be somewhat standardised for the player so they can compare them more directly. Even then, I think having the stats was a failed experiment, and it's more fun for the player to only get the stats that are unique to towers, like lightning chance or fire damage. 

The idea of the stats is so a player knows which tower is more helpful to them. Rather than giving them stats, what would be better (and what most games do) is keep count of how much damage a tower has done in each round and display a list of the towers in order of damage dealt. I couldn't do this because the way I programmed the game was such that a bullet had no reference to it's creator so it couldn't let them know if it hit anything. In hindsight, this is the obvious way to develop a game like this, but since I was new to game development, I didn't think of it. 

Having a system like this would've made the game much easier to balance.

As the game is now it's probably still a tad too difficult for the average player and most players won't have the patience to persist to the first win. This is both problematic for the sales, but intended for gatekeeping the playerbase to an extent. I think if I'd made the game any easier, people would be able to simply breeze through it because I wouldn't know how to finetune it just right due to inadequate knowledge of the strength of various towers. Balancing is so integral to games and I really underestimated that with this game. 

I think a lot of people want to play 'unbalanced' games in which a player has the opportunity to become a god - think Risk of Rain 2 or Binding of Isaac. This potential to be unstoppable is often confused with the term 'unbalanced', because a game can be simultaneously difficult and give the player the opportunity to pop off. The idea with bugTDX is that you could find a good build and just cruise to the end of the game, but due to the game being pretty influenced by Super Auto Pets, I was used to having to struggle to the last win, even with a good build. That's perhaps a convoluted way for me to say I wanted the game never to be too easy, but it fluctuates dramatially from being too easy to too hard and seldom does it lie in the sweet spot.

### variety

A selling point of bugTDX is its 40+ towers (45 in total from memory), which I was pretty proud of. However introducing a huge potential pool of towers also introduces problems that fundamentally alter the game and make it simply less enjoyable. Games like Binding of Isaac can get away with item bloat (having too many items) because the items aren't often stacked so you *want* unique items each time. In bugTDX, success requires having towers of high level, which means you have to roll the same towers to level them up. It's way too RNG based for my liking, and I think it really impacts my enjoyment of a run because I feel like I'm being penalised by attempting to level a tower up because there's no immediate incentive. Furthermore, as the run progresses and the tower pool grows, the shop space does not. You are constantly bound to three spots in the shop despite the huge increase of towers. Three spots often feels too few for even the first few rounds with a pool of about 11 towers, so the problem just gets worse over time. It also places a lot of value on the xpbooster, because it becomes an invaluable asset to leveling up most of your towers because it can level multiple at once. 

There's a few possible solutions to item bloat. You can tailor the pool to the player's build. This might just mean that you're likely to get towers you already have, but then this might mean that you're getting tons of tier 1 towers when there's tier 4 towers available. Another solution is to just reduce the probability of getting worse items as time passes. This is pretty good because then you're only getting towers you want at the end because the most valuable towers are tier 4, but it also cuts out majority of the tower pool and makes tier 1s redundant. The best solution in my opinion is what Super Auto Pets does, which is just give the player as many options all the time. When you level up a tower you get new towers of a higher tier, as well as the shop spaces increasing over time. 

I'll certainly have an auto-chess shop in my next game, and I'm going to take the SAP route. It's a simple solution for the developer, and it means the player can have lots of fun choices!

### boredom

It's hard to admit, but bugTDX can be boring. I normally play it while watching TV, but it can be incredibly dull if your attention is focused solely on the game because during a wave there just isn't much to do. I'd always end up playing water builds because it speeds up the gameplay. The speed of the game was bound to pretty much 1x because otherwise a projectile would be on one side of the enemies on one frame, and on the other side on the next frame. So when there was a particularly long wave, or your strategy was dependent on one of the many support towers that slowed enemies, you'd just have to sit there. Inactivity is *never* fun and players always need something to do, even if it's just menial clicking buttons. 

I could've made the mouse pointer do the damage, either on click or on move. I've never seen this been done before and it could be difficult to implement but it'd be another little gimmick to dinstinguish the game. I also could've made AoE spells like in Clash of Clans to add an additional strategic layer to the waves. I could've just unlocked the shop during the waves too. Plenty of ways for me to give the player something to do during those waves but unfortunately once you become numb to the once satisfying particle explosions, you're impatient and probably unhappy with the game.

### incentive

I've always been sceptical of battle passes and unlockable consmetics, but in them is an important aspect of developing a game that keeps players coming back. Players need visible goals to strive for that isn't just 'beat the game', as well as rewards with these goals. These rewards should be valuable too, not just lore or costumes. I'm simply not interested in afterthought lore, no matter how intricate it may be. However if I get rewarded for playing a game with more content from that game I already enjoy, I'll be motivated to see what else I can discover. This is all a convoluted way to say that players probably stopped playing because they didn't feel a strong enough urge to see what else the game had to offer. A good thing about roguelites in particular, is that after each run you probably have some currency and some know-how to help you progress further in the next run, so the difficulty curve as you get better is way steeper. Mark Brown from GMTK did a video on the roguelite difficulty curve and how he didn't enjoy how the game got easier rather than you got better, but a well designed game with meta-progression (thinking Dead Cells) will have you get better without necessarily making the game easier. 

In bugTDX, there needed to be incentive for players to get further in the game. A good example is the huge locked screen in Brotato of all of the different characters that require unlocking. I could have showed the players all the different difficulties that remained behind locked doors, or a list of all of the towers that they'd won with and the ones they hadn't won with could've just been a silhoutte. Giving the player an incentive to play again - especially in a genre as inherently punishing to losses as roguelikes - is fundamental to converting new players to established players. Then, a solid game should encourage established players to see all the game they can that isn't just behind unlocks, like achievements and cool builds. 

### ui/ux design

Man this part is rough. All buttons in bugTDX are just floating bits of text that would grey out when you hover over them. To be inspired by SNKRX but not bring over any of the UI design that made that game so satisfying to play is pretty embarrasing. Repeat after me - all buttons need springs. Otherwise it just feels static. I was actually pretty happen with the button system I set up, which was just creating a text box and greying out if the mouse was hovering it. It was made by automatically translating any text into the correct language, creating the box based off the text dimensions, and storing that in a box object that would update whenever the language changed. But at the same time, how often will a player change the language. Once? Twice if the translation is so god-awful that it's just better in English?? Of all of the backend to make nice, this was probably the least neccessary. There's some truly hellish stuff within the bugTDX codebase and I should've focused on that rather than over-engineering a shoddy textbox system that didn't even look good or feel satisfying. 

Then there's the issue with space on the screen. Turns out the game, by default, would start super zoomed out, and players would have no reason to adjust this for themselves. So there was a lot of unused screen space and the odd pixelated graphics were made even worse by being zoomed out. The Surface Laptop is good at many things, it is not good at having a normal display. 150% scaling looks *drastically* different on my computer than it does on a much larger monitor, which I didn't accomodate for adequately. 

## conclusion

I learned a lot from this game. This might seem like a lot of text, but I ended up cutting it down substantially. Major takeaways:

- Doing anything should be satisfying
- Players should want to keep playing
- Players should always have something to do
- A game that looks bad won't be played

Yeah so. Learned a lot. Pretty cool. Thanks for reading/skimming! [Play bugTDX here!](https://store.steampowered.com/app/2336160/bugTDX/)