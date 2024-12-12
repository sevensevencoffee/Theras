import asyncio
from uagents import Agent
from test import SummaryRequest

async def test_agent():
    # Initialize the test agent
    agent = Agent(name="test_client")

    # Define the target agent address
    target_address = "hardcoded_summarizer"

    # Create the summary request
    request = SummaryRequest(table_name="hardcoded_data", limit=5)

    # Send the request and await a response
    response = await agent.request(target_address, request, timeout=10)

    if response:
        print("Summary Response:")
        print(response.dict())
    else:
        print("No response received from the agent.")

# Run the test
asyncio.run(test_agent())
