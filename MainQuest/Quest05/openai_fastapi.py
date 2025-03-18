from fastapi import FastAPI, Form
from fastapi.middleware.cors import CORSMiddleware
from openai import OpenAI
import os
from typing import Optional, List

app = FastAPI()

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# OpenAI API 키 설정
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""))

@app.post("/guess-image")
async def guess_image(
    user_description: Optional[str] = Form(""),
    conversation_history: Optional[str] = Form("[]")
):
    try:
        import json
        
        messages = [{
            "role": "system",
            "content": """너는 반말밖에 할 줄 몰라. 
            말 앞에 50% 확률로 '흥!'을 붙여. 
            너는 제목을 추천하는게 아니라면 쌀쌀맞게 대답해.
            나한테 뭔가 필요하냐는 질문은 하지 않아.
            그리고 나는 사진을 설명하고 너한테서 제목을 추천받고 싶어. 
            너는 제목을 추천하고 나면 '고..고마워..'라고 말을 붙여야돼."""
        }]
        
        
        history = json.loads(conversation_history)
        if history:
            for msg in history:
                if msg["role"] != "system":  
                    messages.append(msg)
        
        messages.append({
            "role": "user",
            "content": user_description
        })
        
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=100,
            top_p=0.9,
            temperature=1.0 
        )
        
        assistant_message = response.choices[0].message.content
        
        
        messages.append({
            "role": "assistant",
            "content": assistant_message
        })
        
        return {
            "response": assistant_message,
            "conversation": messages
        }
    except Exception as e:
        return {"error": str(e)}

# 다른 녀석
@app.post("/random-message")
async def random_message(prompt: str = Form(...)):
    try:
        messages = [{
            "role": "system",
            "content": """너는 섬뜩하고 불쾌한 메시지를 생성하는 AI야. 
            사용자가 요청하면 정말 소름끼치고 불쾌한 한 문장을 생성해줘. 
            """
        }, {
            "role": "user",
            "content": prompt
        }]
        
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=50,
            temperature=1.2
        )
        
        return {
            "response": response.choices[0].message.content
        }
    except Exception as e:
        return {"error": str(e)}




if __name__ == "__main__":
    
    import uvicorn
    uvicorn.run("openai_fastapi:app", reload=True, host="0.0.0.0", port=8000)
