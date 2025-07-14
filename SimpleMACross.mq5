//+------------------------------------------------------------------+
//|                                                  SimpleMACross.mq5 |
//|                      BHIGSMARTZ-FX                                |
//+------------------------------------------------------------------+
#property copyright "BHIGSMARTZ-FX"
#property link      "https://github.com/BHIGSMARTZ-FX"
#property version   "1.00"
#property strict

input int FastMAPeriod = 10;
input int SlowMAPeriod = 25;
input double LotSize = 0.1;
input int StopLoss = 100;
input int TakeProfit = 200;

int fastMA, slowMA;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   fastMA = iMA(NULL, 0, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE);
   slowMA = iMA(NULL, 0, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE);
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   double fastPrev = iMA(NULL, 0, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 1);
   double slowPrev = iMA(NULL, 0, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 1);
   double fastCurr = iMA(NULL, 0, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 0);
   double slowCurr = iMA(NULL, 0, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE, 0);

   // Buy Signal
   if (fastPrev < slowPrev && fastCurr > slowCurr)
     {
      if (PositionSelect(Symbol()) == false)
        {
         trade.Buy(LotSize, Symbol(), Ask, StopLoss * _Point, TakeProfit * _Point, NULL);
        }
     }

   // Sell Signal
   if (fastPrev > slowPrev && fastCurr < slowCurr)
     {
      if (PositionSelect(Symbol()) == false)
        {
         trade.Sell(LotSize, Symbol(), Bid, StopLoss * _Point, TakeProfit * _Point, NULL);
        }
     }
  }