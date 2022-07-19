StalkFinance Design Project - README
===

# StalkFinance 

 **StalkFinance**: Allows uses to see real time information about stocks and crypto regarding price, analysis, and financial statements in a timeline like feed. Contains built-in public chat-rooms feature that users can create to share financial insights or an in app link to a stock/crypto  details page to a particular chat-room thread.

### Stock/Crypto Feed Data
**Yahoo Finance API**
#### https://www.yahoofinanceapi.com/

**Financial Modeling Prep**
#### https://site.financialmodelingprep.com/developer/docs/#Earning-Call-Transcript

**Finnhub**
#### https://finnhub.io/docs/api

**News Data**
#### https://newsapi.org/

Chat-Channel
#### https://www.pubnub.com/docs/sdks/objective-c/api-reference/channel-groups
* For Chat Rooms/Collaboration 

### Opportunity for Complexity
- Using multiple api's for access to low-latency data for stock crypto and news data models to gather all desired data amongst utilizing Parse for backend authentication and chat-channel feature
- Personalized Newsfeed for each user based on time spent on user content + more signals

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Allows users to see real time information about stocks and cryptocurrency regarding price, charts, earnings call analysis and financial statements in a timeline and a details view. Implements chat functions for hedge funds/orgs that want to share financial statements or in app link to a chart/company stock details page.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**: Finance / Social Networking
- **Mobile:**: This app is targeted to iOS mobile users. Functionality is not limited to just mobile devices however, the spirit of the app is meant to be on convenient on-the-go devices.
- **Story:**: Users can access information about stocks and cryptocurrencies' exchange rate with the USD. Users can also post to a feed in a desired chat room or create a custom public chat room 
- **Market:**: This app is for any individuals who are interested in being informed regarding details about stocks and cryptocurrencies and having a platform to discuss with others about stock and crypto subtopics.
- **Habit:**: This app should be used as a tool to help with financial decisions regarding investments as much as needed.
- **Scope:**: This app would be data and user-driven in terms of what a potential user want to do on the app. Users can read, analyze, and discuss about topics related to investing in stocks and cryptocurrencies.

## Product Spec

### 1. User Stories (Required and Optional)

### **Required Must-have Stories**

- [X] User can sign up to create a new account using backend databse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can use a tab bar to surface  stock, crypto, and chat views.
- [X] User can view stock prices as a preview in a timeline feed
- [X] User can view crypto prices as a preview in a timeline feed
- [X] User can pull to refresh either crypto/stock timeline to get updated prices
- [X] Implements a fade in  animation when allowing user to tap a stock cell to view stock details, trading volume, analysis, and insights
- [X] Implements a fade in  animation when allowing user to tap a crypto cell to view crypto details such as trading volume, analysis, and insights
- Users can see a default news feed in the respective tab with at least three articles.
- Users can see a personalized news feed in the respective tab after taking time to search/view certain stocks and cryptocurrencies.
- Users can create a chat room with a custom title
- Users can post a chat to a chat room
- Users can see existing public chat rooms
- Users can double tap on a chat to like, increasing the like count
- Users can share a particular stock/crypto detail page to a desired room thread as a post
- Users can click on links that appear in chats
- Incorporates at least one external library to add visual polish


### **Optional Nice-to-have Stories**
* Search bar to search for a particular
   - stock
   - crypto
   - news article/source
   - chat room
* Profile page for each user
* Allow users to make sub-comments on a comment




### 2. Screen Archetypes

* Login

* Signup
    * Login Action
* Stock Price/Chart Feed
   * Simple Stock Preview (Price)
   -- Detailed Price Detail & Analysis & Insights

* Crypto Price/Chart Feed
   * Simple Crypto Price Preview 
   -- Detailed Price, Analysis, & Insights
   
* Newsfeed 
   -- Tabular news display
   -- Tap gesture recognizer to send user to Safari to read full text of synopsis. 

* Chat 
   * Public Chat Room Display
   -- Chat Room Conversation Thread
   -- Allows users post chats to a particular room thread 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stock Feed
* Chat-room Feed
* Crypto Feed
* NewsFeed

**Flow Navigation** (Screen to Screen)

* Login view -> Sign up view is user doesn't have  credentials already

* Stock feed view -> Specific stock details view

* Crypto feed view -> Specific crypto details view

* Public chat-rooms view -> Specific chat-room thread

* NewsFeed view -> Safari

## Wireframes
* See wireframes.pdf in directory
## Schema 

### Models

### Stock 

|Property |Type| Description|
|-----|--------|--------|
|ticker|String     |stock symbol of the entity|
|companyName  |String      |full name of the publicly traded company|
|currentPrice  |Number     |the current price of one share of the publicy held company|
|openPrice  |Number      |the price at the beginning of the trading day|
|percentChange  |Number      |the change in price from openPrice to currentPrice as a percentage|
|highPrice  |Number      |the stock's highest price of the trading day|
|lowPrice  |Number      |the stock's lowest price of the trading day|
|tradingVolume  |Number     |the number of shares that changed hands during a given day|
|lowFiftyTwo  |Number      |the stock's lowest price per share of the trading year (past 52 weeks)|
|highFiftyTwo  |Number      |the stock's highest price per share of the trading year (past 52 weeks)|
|insight  |String      |insight summary about the stock's performance|
|insightTitle  |String      |title of the insight article |
|insightProvider  |String      |author of the insight article|
|insightDate  |DateTime      |date of publication of the insight article|


### Crypto

|Property |Type| Description|
|-----|--------|--------|
|ticker|String     |crypto acronym|
|symbol|String     |crypto symbol (e.g. Ƀ for Bitcoin)|
|cryptoName  |String      |full name of the cryptocurrency|
|currentPrice  |Number     |the current price of one coin (USD)|
|openPrice  |Number      |the price at the beginning of the 24 hour window|
|percentChange  |Number      |the change in price from openPrice to currentPrice as a percentage|
|tradingVolume  |Number     |how much value of a coin has been bought and sold over the course of a day|
|lowTwentyFour  |Number      |the crypto's lowest price per share of the day (past 24 hours)|
|highTwentyFour |Number      |the crypto's highest price per share of the day (past 24 hours)|

### NewsFeed

|Property |Type| Description|
|-----|--------|--------|
|author|String     |author of published document|
|title|String     |title of published document|
|content  |String      |composed text/insight|
|urlImage|URL     |Image associated with news article|
|urlToArticle|URL     |Link to article|

### Chat

|Property |Type| Description|
|-----|--------|--------|
|userId|String     |username|
|chatRoomId|String     |chatRoom name|
|chatPost  |String      |composed text/insight|



### Networking
Stock and Crypto Data API - Yahoo Finance 

Base URL - https://yfapi.net
Base URL - https://alpha.financeapi.net

|HTTP Verb |Endpoint| Description|
|-----|--------|--------|
|GET| /v7/finance/options/{symbol}| retrieves info about options trading regarding the specific stock using its symbol|
|GET| /ws/insights/v1/finance/insights?symbol={symbol}     |retrieves analysis and research insights regarding a stock |
|GET  |/market/get-realtime-prices    | real time quote data for stocks, ETFs, mutuals funds, etc…

News API

|HTTP Verb |Endpoint| Description|
|-----|--------|--------|
|GET| /v2/everything| "Search every article published by over 80,000 different sources large and small in the last 4 years. This endpoint is ideal for news analysis and article discovery."|
|GET| /v2/top-headlines |"Returns breaking news headlines for countries, categories, and singular publishers. This is perfect for use with news tickers or anywhere you want to use live up-to-date news headlines." |
