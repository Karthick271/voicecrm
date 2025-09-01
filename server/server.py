from fastapi import FastAPI, File, Form, UploadFile, Depends, HTTPException, Header
from fastapi.responses import FileResponse
import uvicorn
import os
from datetime import datetime

app = FastAPI()

UPLOAD_DIR = "recordings"
os.makedirs(UPLOAD_DIR, exist_ok=True)

# 🔑 Security Key
API_KEY = "super-secret-key-123"   # change this!
API_KEY_NAME = "X-API-KEY"         # header name

# middleware dependency
def verify_api_key(x_api_key: str = Header(...)):
    if x_api_key != API_KEY:
        raise HTTPException(status_code=401, detail="Unauthorized")


@app.post("/api/call-logs")
async def upload_call(
    number: str = Form(...),
    timestamp: str = Form(...),
    recording: UploadFile = File(...),
    _: str = Depends(verify_api_key)   # enforce API key
):
    safe_number = number.replace("+", "").replace(" ", "")
    filename = f"{safe_number}_{int(datetime.now().timestamp())}.m4a"
    file_path = os.path.join(UPLOAD_DIR, filename)

    with open(file_path, "wb") as f:
        f.write(await recording.read())

    return {"status": "success", "file": file_path, "number": number, "timestamp": timestamp}


@app.get("/api/recordings")
def list_recordings(_: str = Depends(verify_api_key)):
    files = os.listdir(UPLOAD_DIR)
    return {"recordings": files}


@app.get("/api/recordings/{filename}")
def get_recording(filename: str, _: str = Depends(verify_api_key)):
    file_path = os.path.join(UPLOAD_DIR, filename)
    if os.path.exists(file_path):
        return FileResponse(file_path, media_type="audio/m4a", filename=filename)
    raise HTTPException(status_code=404, detail="File not found")


if __name__ == "__main__":
    uvicorn.run("server:app", host="0.0.0.0", port=8000, reload=True)
