from uagents import Agent, Context, Model
import pandas as pd


class SummaryRequest(Model):
    """
    Request model for summarization.
    """
    table_name: str  # Placeholder for table name
    limit: int = 100


class SummaryResponse(Model):
    """
    Response model for summarization.
    """
    summary: dict


# Instantiate the agent with an endpoint
agent = Agent(
    name="mood_summarizer",
    endpoint=["http://127.0.0.1:8000"]
)

@agent.on_message(model=SummaryRequest)
async def handle_summary_request(ctx: Context, request: SummaryRequest):
    """
    Handle summarization requests with hardcoded data.
    """
    try:
        # Hardcoded data
        data = {
            "id": [1, 2, 3, 4, 5],
            "value": [10.5, 20.3, 30.7, 40.1, 50.2],
            "category": ["A", "B", "A", "C", "B"],
            "timestamp": pd.date_range(start="2023-01-01", periods=5, freq="D")
        }
        dataframe = pd.DataFrame(data)

        # Summarize the data
        summary = {
            "description": dataframe.describe(include="all").to_dict(),
            "null_counts": dataframe.isnull().sum().to_dict(),
            "data_types": dataframe.dtypes.astype(str).to_dict(),
        }

        # Send the summary response
        response = SummaryResponse(summary=summary)
        await ctx.reply(response)
    except Exception as e:
        await ctx.error(f"Error processing the request: {str(e)}")


# Run the agent
if __name__ == "__main__":
    agent.run()
