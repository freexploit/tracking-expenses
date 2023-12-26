import asyncio
from gql import Client, gql
from gql.transport.aiohttp import AIOHTTPTransport
from datetime import datetime
import functools 

# from operator import add from functools import reduce


today=datetime.today().strftime('%Y-%m-%d')

async def main():


    transport = AIOHTTPTransport(url="http://localhost:8080/v1/graphql")

    # Using `async with` on the client will start a connection on the transport
    # and provide a `session` variable to execute queries on this connection
    async with Client(
        transport=transport, fetch_schema_from_transport=True,
    ) as session:

        # Execute single query
        query = gql(
            """
            query MyQuery ($today: date!){
              expenses_bac_credomatic(where: {date: {_lte: $today, _gte: $today}}) {
                currency
                commerce
                amount
              }
            }

        """
        )
        params = {
            "today": today,
        }

        result = await session.execute(query, variable_values=params)


        total_usd = list(filter(lambda x: x['currency'] == 'USD', result['expenses_bac_credomatic']))
        total_crc = list(filter(lambda x: x['currency'] == 'CRC', result['expenses_bac_credomatic']))

        sum_crc = functools.reduce(lambda x,y: x+y, list(map(lambda x: x['amount'],total_crc)), 0)
        sum_usd = functools.reduce(lambda x,y: x+y, list(map(lambda x: x['amount'],total_usd)), 0)

        print("Gastos totales en colones: {}\n".format(sum_crc))
        print("Gastos totales en dolares: {}\n".format(sum_usd))



if __name__ == "__main__":
    # print(gather_data())
    asyncio.run(main())
    
