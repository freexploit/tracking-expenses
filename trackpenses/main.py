import asyncio
from gql import Client, gql
from gql.transport.aiohttp import AIOHTTPTransport
from notmuch import gather_data
# from operator import add from functools import reduce

async def main():

    data = gather_data()
    # print(data)

    reqHeaders = {
        'x-hasura-admin-secret' :'4.5TfTRTxmtpqCG64IAhY.e96FT7_5FSrO4~iXNQnGAbJU.dotDh7bbCQTESg388EuARFkKy' ,
    }

    transport = AIOHTTPTransport(url="http://graphql-engine-graphql-engine:8080/v1/graphql", headers=reqHeaders)

    # Using `async with` on the client will start a connection on the transport
    # and provide a `session` variable to execute queries on this connection
    async with Client(
        transport=transport, fetch_schema_from_transport=True,
    ) as session:

        # Execute single query
        query = gql(
            """
            mutation ($data: [expenses_bac_credomatic_insert_input!]!) {
              insert_expenses_bac_credomatic(objects: $data) {
                returning {
                  id
                }
              }
            }
        """
        )
        params = {
            "data": data
        }

        result = await session.execute(query, variable_values=params)
        print(result)


if __name__ == "__main__":
    # print(gather_data())
    asyncio.run(main())
    
