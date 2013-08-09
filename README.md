# KYou

Through our webtools, our objects and our collaborations we create an huge
amount of various personal data. Unfortunately we can't take advantage of it
at its full potential. That's a pity because it could teach a lot of about
ourselves. The world of personal data is like an unexplored land: we don't
really know where to go but we are sure that there are a lot of new suprises
awaiting for us.

KYou is the first steps through this new country. By building analytics
from your [Cozy](http://cozy.io) data, it provides you the first shapes of a 
better knowledge of yourself. With this new insights I expect you will learn 
more about you and via that new entries, improve yourself.


## Trackers

Analytics are built from trackers. There are three kinds of trackers
(only the two first ones have benn implemented yet):

* a tracker that aggregates data from your Cozy
* a tracker that requires a daily recording from you
* a tracker that aggregates data from outside your Cozy

They all track a quantity on a daily basis. Kyou displays only what happens the
last six months. Why this constraint? Because analytics could become quickly
complex and hard to interpret. By keeping these informations simple, KYou
provides easy to read informations. 

## Available trackers

**Mood** Store your mood every day and look if there is correlation with other
analytics.

**Task** Count how many tasks were marked done every day. Data comes from 
[Cozy Todos](https://github.com/mycozycloud/cozy-todos)

**Mails** Count how many mails you received every day. Data comes from 
[Cozy Mails](https://github.com/mycozycloud/cozy-mails)

## What about contributions?

Here are the next things I have mind and not started yet. Your participation to
them would be highly appreciated.

* weather tracker: store your location and track temperature and pluviometry.
* coffee consumption tracker: every day stores the amount of cup of coffee you
  drinked.
* alcohol consumption tracker: every day stores the amount of glass  of alcohol
  you drinked.
* make tracker more modular and easier to code.
