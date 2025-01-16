import requests
from bs4 import BeautifulSoup
import time
from datetime import datetime

def get_previous_close(ticker, exchange):
    url = f"https://www.google.com/finance/quote/{ticker}:{exchange}"
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    try:
        response = requests.get(url, headers=headers)
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Find the Previous close value by looking for the label first
        previous_close_label = soup.find('div', string='Previous close')
        if previous_close_label:
            # Get the parent container and then find the price element within it
            price_container = previous_close_label.find_parent('div')
            
            # Try multiple possible class names and patterns
            price_element = price_container.find('div', {'class': ['YMlKec', 'fxKbKc']})
            if not price_element:
                # Try finding any div that contains a dollar amount
                price_element = price_container.find('div', text=lambda t: t and '$' in t)
            
            if price_element:
                previous_close = price_element.text
                # Remove any currency symbols and convert to float
                previous_close = float(previous_close.replace('$', '').replace(',', ''))
                return previous_close
        return None
    except Exception as e:
        print(f"Error fetching data for {ticker}:{exchange}: {str(e)}")
        return None

def main():
    # Dictionary mapping stocks to their exchanges
    stocks = {
        # NASDAQ stocks
        'AAPL': 'NASDAQ',
        'NVDA': 'NASDAQ',
        'MSFT': 'NASDAQ',
        'GOOG': 'NASDAQ',
        'AMZN': 'NASDAQ',
        'META': 'NASDAQ',
        'TSLA': 'NASDAQ',
        'AVGO': 'NASDAQ',
        'COST': 'NASDAQ',
        'NFLX': 'NASDAQ',
        
        # NYSE stocks
        'BRK.B': 'NYSE',
        'WMT': 'NYSE',
        'JPM': 'NYSE',
        'LLY': 'NYSE',
        'V': 'NYSE',
        'UNH': 'NYSE',
        'XOM': 'NYSE',
        'MA': 'NYSE',
        'ORCL': 'NYSE',
        'HD': 'NYSE',
        'PG': 'NYSE',
        'BAC': 'NYSE',
        'JNJ': 'NYSE',
        'CRM': 'NYSE',
        'ABBV': 'NYSE'
    }

    print(f"\nFetching stock prices from Google Finance as of {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    total_sum = 0
    valid_prices = 0
    
    # Fetch data for each ticker
    for ticker, exchange in stocks.items():
        prev_close = get_previous_close(ticker, exchange)
        if prev_close is not None:
            total_sum += prev_close
            valid_prices += 1
            print(f"{ticker:<6} ({exchange:<6}) Previous Close: ${prev_close:,.2f}")
        else:
            print(f"{ticker:<6} ({exchange:<6}) Previous Close: Data unavailable")
        # Add a small delay to avoid hitting rate limits
        time.sleep(1)
    
    print("\nSummary:")
    print(f"Total sum of previous close prices: ${total_sum:,.2f}")
    print(f"Number of stocks with valid prices: {valid_prices} out of {len(stocks)}")
    if valid_prices < len(stocks):
        print("Note: Some stock prices were unavailable and not included in the total.")
if __name__ == "__main__":
    main() 

"""
AAPL   (NASDAQ) Previous Close: $233.28
NVDA   (NASDAQ) Previous Close: $131.76
MSFT   (NASDAQ) Previous Close: $415.67
GOOG   (NASDAQ) Previous Close: $191.05
AMZN   (NASDAQ) Previous Close: $217.76
META   (NASDAQ) Previous Close: $594.25
TSLA   (NASDAQ) Previous Close: $396.36
AVGO   (NASDAQ) Previous Close: $224.70
COST   (NASDAQ) Previous Close: $917.23
NFLX   (NASDAQ) Previous Close: $828.40
BRK.B  (NYSE  ) Previous Close: $450.09
WMT    (NYSE  ) Previous Close: $90.78
JPM    (NYSE  ) Previous Close: $247.41
LLY    (NYSE  ) Previous Close: $744.40
V      (NYSE  ) Previous Close: $309.16
UNH    (NYSE  ) Previous Close: $543.66
XOM    (NYSE  ) Previous Close: $109.69
MA     (NYSE  ) Previous Close: $509.09
ORCL   (NYSE  ) Previous Close: $156.32
HD     (NYSE  ) Previous Close: $392.81
PG     (NYSE  ) Previous Close: $159.74
BAC    (NYSE  ) Previous Close: $45.79
JNJ    (NYSE  ) Previous Close: $144.75
CRM    (NYSE  ) Previous Close: $323.62
ABBV   (NYSE  ) Previous Close: $173.88

Summary:
Total sum of previous close prices: $8,551.65
Number of stocks with valid prices: 25 out of 25
"""
