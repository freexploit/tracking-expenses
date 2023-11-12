import asyncio
from gql import Client, gql
from gql.transport.aiohttp import AIOHTTPTransport
import functools 
import json

# from operator import add from functools import reduce



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
            query MyQuery {
              expenses_bac_credomatic {
                date
                currency
                commerce
                amount
                location
                card_type
                card_number
                id
              }
            }
        """
        )

        result = await session.execute(query)


        print("{}\n".format(json.dumps(result)))



if __name__ == "__main__":
    # print(gather_data())
    asyncio.run(main())
    
