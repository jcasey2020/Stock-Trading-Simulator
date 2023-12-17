# Stock-Trading-Simulator
This project allows users to record the price of a stock over time and test three different trading strategies (historical comparison, real-time buying decision, real-time selling decision)

Functionalities:
This project allows users to record the price of a stock over time and test three different trading strategies.
• Strategy 1 (Historical Comparison): This strategy allows the user to analyze a stock’s historical prices to find times during which the stock rose by a specified percent. For example, if the user is interested in studying >5% increases, the program will return every combination of times during which the stock increased by at least 5%. The output would include: between Nov 30, 2023, 13:01:00 UTC and Nov 30, 2023, 17:35:00 UTC, {stock name} increased by 0.201261%, along with all the other time combinations when the stock rose by at least 5%. This allows the user to analyze patterns and trends that will help to create their trading strategy.

• Strategy 2 (Real-time Buying Decision): This strategy allows the user to specify parameters for buying a stock. The user inputs a percentage increase that they want the stock to experience before deciding to buy, followed by a time parameter over which that increase must be seen. Many day traders buy stocks when they increase a certain amount over a certain amount of time. This program allows them to watch for these increases and get notified as soon as they happen. The user is then asked for the amount of time they want to hold the stock before deciding to sell. For example, a user may have determined that a profitable trading strategy is to buy a stock if it has increased by 3% over a ten-minute period, and then hold the stock for another ten minutes before selling. This program allows them to do that.

• Strategy 3 (Real-time Selling Decision): This strategy allows the user to sell their stock when the price hits a specified number. If a trader owns a stock, they have likely determined a price at which they plan to sell it. The program asks the user to input that price, then notifies them when the stock has reached it. If the parameter is not met, the program outputs: Waiting for the current price to reach or exceed the sell price parameter. When the sell parameter is met, the program outputs (for example): you sold at Nov 30, 2023, 20:06:54 UTC for $188.98.

Files:
cleanfile.sh cleanprices.txt finalpricelist.txt recordprice.sh strategy.sh tempprices.txt ticker.sh
