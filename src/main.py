from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def message():
    return "privet, mir"


if __name__ == '__main__':
    uvicorn.run(app, port=80, host="0.0.0.0")
