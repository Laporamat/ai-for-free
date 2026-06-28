#!/usr/bin/env python3
import json
import random
import os
import requests

def load_perfume_knowledge():
    knowledge_file = os.path.join(os.path.dirname(__file__), '../../perfume_knowledge.json')
    with open(knowledge_file, 'r', encoding='utf-8') as f:
        return json.load(f)

def generate_response(user_input):
    knowledge = load_perfume_knowledge()
    user_input = user_input.lower()
    
    response = ""
    
    if any(keyword in user_input for keyword in ['สวัสดี', 'hello', 'hi', 'hey']):
        response = f"🌸 สวัสดีค่ะ! ฉันคือ Perfume AI ค่ะ!\n{knowledge['welcome']}"
    elif any(keyword in user_input for keyword in ['องค์ประกอบ', 'ingredient', 'ingredients', 'ส่วนผสม']):
        ingredients = random.sample(knowledge['common_ingredients'], min(3, len(knowledge['common_ingredients'])))
        response = "🌿 นี่คือองค์ประกอบน้ำหอมยอดนิยม 3 ชนิดค่ะ:\n"
        for ing in ingredients:
            response += f"- **{ing['name']}** ({ing['note']})\n  {ing['description']}\n"
    elif any(keyword in user_input for keyword in ['กลิ่น', 'fragrance', 'fragrances', 'family', 'families', 'ประเภท']):
        families = random.sample(knowledge['fragrance_families'], min(3, len(knowledge['fragrance_families'])))
        response = "🏵️ นี่คือตระกูลกลิ่นหอม 3 ตระกูลค่ะ:\n"
        for fam in families:
            response += f"- **{fam['name']}**\n  {fam['description']}\n"
    elif any(keyword in user_input for keyword in ['ออกแบบ', 'design', 'tip', 'tips', 'เคล็ดลับ', 'วิธี']):
        tips = random.sample(knowledge['design_tips'], min(3, len(knowledge['design_tips'])))
        response = "✨ นี่คือเคล็ดลับออกแบบน้ำหอม 3 ข้อค่ะ:\n"
        for tip in tips:
            response += f"- {tip}\n"
    elif any(keyword in user_input for keyword in ['ขอบคุณ', 'thanks', 'thank you', 'thankyou']):
        response = "🙏 ด้วยความยินดีค่ะ! ถ้ามีคำถามอื่นๆ เกี่ยวกับน้ำหอม ถามได้ตลอดเลยนะคะ!"
    else:
        response = "🤔 ขออภัยค่ะ ฉันยังไม่เข้าใจคำถามของคุณเท่าไหร่ ค่ะ!\nคุณสามารถถามเกี่ยวกับ:\n- องค์ประกอบน้ำหอม\n- ตระกูลกลิ่นหอม\n- เคล็ดลับออกแบบน้ำหอม\nได้เลยนะคะ!"
    
    return response

def post_comment(issue_number, comment):
    token = os.getenv('GITHUB_TOKEN')
    repo = os.getenv('GITHUB_REPOSITORY')
    url = f"https://api.github.com/repos/{repo}/issues/{issue_number}/comments"
    
    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/vnd.github.v3+json"
    }
    data = {"body": comment}
    
    response = requests.post(url, headers=headers, json=data)
    response.raise_for_status()
    print(f"Posted comment successfully to issue #{issue_number}")

if __name__ == "__main__":
    issue_number = os.getenv('ISSUE_NUMBER')
    comment_body = os.getenv('COMMENT_BODY', '')
    
    if not issue_number:
        print("ISSUE_NUMBER is required!")
        exit(1)
    
    ai_response = generate_response(comment_body)
    post_comment(issue_number, ai_response)
