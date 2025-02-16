---
title: Marital Happiness Metric, Love and Arranged Marriages
date: 15-02-2025
categories:
  - Article
math: true
layout: post
---

Are love marriages any better than arranged marriages? I would like to advocate this in the article. 

The single thing that matters the most in marriages is harmony between husband and wife. All other factors can be resolved by either law enforcement or open discussion between the concerned parties. A marriage in which husband and wife are not on the same page is doomed to break; and if it sustains, it would be a hell to live through. 

Given two people are to come together to spend the rest of their lives together, it is essential that they have a common ground to start with. In simple terms, their opinions should match on various different topics. It is not necessary that they should agree on every single thing (it would be wonderful if they do), but they should at least agree on the things that matter the most to them. If they don't, then the conflict of opinion arises, and it all goes down to the art of conflict resolution and making compromises. 

## Opinion vectors and OAM
So the basic requirement of a happy successful marriage is that the couple's ideologies should match in as many different directions as possible. To express this in a mathematical model, think of a big opinion vector space with multiple dimensions. Here, each dimension represents a different prospect to have an opinion. For example, you ask a person their political leaning on a scale where $-\infty$ is far left (liberal) and $\infty$ is far right (conservative). {$\infty$ here is just a big number, take $10$ for example.} On another axis, take some other linearly independent question, for example- Who should take care of the children? (I am out of creative ideas for questions but you get the point.). You ask their opinion between $-\infty$ being only men, and $\infty$ being only women. (sign convention is arbitrary).

If you plot these two numbers in a plane, you will get a vector. This is called _the opinion vector_.[^1] Of course, not all the questions have the same weight, so you need to scale these vectors with a weight matrix. You compute the scaled opinion vector for two people, and take the dot product; you will get a scalar quantity representing how well their opinions align. You can call this quantity __Opinion Alignment Metric (OAM)__. But since this represents the harmony in married couples, I will call this __Marital Harmony Metric (MHM)__.  

![Light mode only](assets/opinion-space-light.png)
{: .light }<br>![Dark mode only](assets/opinion-space-dark.png){: .dark }_a simple representation of opinion space where on the x-axis is political views and on the y axis is who should cook food or something_

The greater this number, the greater the cooperation between two people, the happier the life. For illustration purposes, I have made a 2-D figure, but you should try to extend this to as many dimensions as possible. As you can see, a person named $A$ is more likely to have a happier life with $B$ despite the slight difference between their political views. But with someone whose opinion lies in the faraway corner of the graph, like person $C$, life is going to be tough. The angle here is too much, and _OAM_ is going to be negative. 

The best bet here is when your opinion vector lies on top of your partner's, in which case the cosine will be $1$. This is not going to happen unless you decide to marry yourself. The worst case is an antiparallel line with a cosine of $-1$. And that is as impossible. 

## Success of Arranged Marriages 
Before we go to that question, we need to understand why arranged marriages had this good run in the past. I am going to write this section with my personal observations. I might miss something here, and might be wrong. 

If women (or men) are not educated enough, they don't give much attention to things. In that case, their opinion vectors sit on the origin. This ensures that OAM never goes below the zero line. 

The best way to ensure a high OAM is that wives agree to everything their husband says. This is the one tradition that has kept arranged marriages alive till date. Men watch news, women watch serials, men decide who to vote for, women comply. Men earn, men decide what to do with money, women comply. Society expects women to ditch their own opinions and follow the orders of their in-laws. Women go to the husband's house and _fit into_ the culture that has already existed and so on. 

In today's world, women have their own opinions independent of their husband, and they are not willing to submit. A conflict is surely going to come up, then arguments, fights and the world knows what comes next. 

The second reason is when you get your ideologies directly from your parents, there will are chances of a happy marriage. In a pre-internet era where access to information was limited, it was common to have your worldview similar to your parents. The marriages are typically arranged in the same society, caste, and class. So the other partner will also come from the same quarter of opinion space. There is a high chance of a greater OAM in such cases. And, this is not too hard to see. If you get along well with your parents, you won't have much problem with the partner they decide for you. 

The third reason is the young age of couples at marriage. When you share the same environment while your ideologies are still developing, then the OAM will obviously be positive. And I don't need to show why this is a hideous idea and doesn't work anymore. 

## Conflict Resolution 

So what happens when a conflict arises in a marriage? One solution, solution A, is that you live together aware of it and don't argue about it. If you respect them enough, you don't care whether they come home drunk. Your wife goes her ways, you are aware of it, but you respect it so don't argue. And she respects you, she don't force you about anything. My cousin brothers are married and this is their life. This sounds very nice, but at one extreme end, it looks like two strangers who sleep together. You might call it a successful marriage but not really a happy marriage. 

This seems an ideal solution but this only works when there is a greater force in action than the conflict. That is love and respect. If your conflict is bigger than your love and respect, it is bound to escalate and break out. 

The other solution, solution B, is to sit together, talk through your differences, make compromises and work that out. In the opinion space, it would be equivalent to rotating the vectors. This only works when a person rotates their vector clockwise and the other rotates counter-clockwise, bringing the vectors closer. In some areas, you compromise and in others, your partner does. This should be done in mutually exclusive directions specially and a marriage can be saved. 

## Love Marriages and Arranged Marriages

Now, given all that information, we can compare love marriage and arranged marriage. If two people have known each other for a long time and they have decided to get married then probably they have similar ideologies and a very high OAM. There are two points to consider. One that they have gone through the evaluation of this. They are not acting on pure blind attraction because attraction will fade out pretty soon. And two, that they have considered enough dimensions. Being religious or not is one prospect, but whether to raise your children religious is another. In most mature couples, they are sensible enough to discuss all these things beforehand, and if they didn't have, probably they couldn't come that far along. And even if a conflict rises between them, both solution A and B work better if there exists a driving force of love between them.

Love can happen between couples after marriage for after marriage fixture and before marriage. But
> There is a difference between loving someone because you want to marry them, and wanting to marry someone because you love them. 

So overall, I can obviously state that love marriages are already ahead.