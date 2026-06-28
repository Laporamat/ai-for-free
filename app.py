import json
import random

def load_knowledge():
    with open('perfume_knowledge.json', 'r', encoding='utf-8') as f:
        return json.load(f)

def get_response(user_input):
    knowledge = load_knowledge()
    user_input = user_input.lower()
    
    if any(keyword in user_input for keyword in ['สวัสดี', 'hello', 'hi']):
        return knowledge['welcome']
    
    elif any(keyword in user_input for keyword in ['องค์ประกอบ', 'ingredient', 'ส่วนผสม']):
        ingredients = random.sample(knowledge['common_ingredients'], 3)
        response = "นี่คือ 3 องค์ประกอบน้ำหอมยอดนิยม:\n"
        for ing in ingredients:
            response += f"- {ing['name']} ({ing['note']}): {ing['description']}\n"
        return response
    
    elif any(keyword in user_input for keyword in ['กลิ่น', 'fragrance', 'family', 'ประเภท']):
        families = random.sample(knowledge['fragrance_families'], 3)
        response = "นี่คือ 3 ตระกูลกลิ่นหอม:\n"
        for fam in families:
            response += f"- {fam['name']}: {fam['description']}\n"
        return response
    
    elif any(keyword in user_input for keyword in ['ออกแบบ', 'design', 'tip', 'เคล็ดลับ']):
        tips = random.sample(knowledge['design_tips'], 3)
        response = "นี่คือ 3 เคล็ดลับการออกแบบน้ำหอม:\n"
        for tip in tips:
            response += f"- {tip}\n"
        return response
    
    else:
        return "ขออภัย ฉันยังไม่เข้าใจคำถามของคุณ คุณสามารถถามเกี่ยวกับองค์ประกอบน้ำหอม, ตระกูลกลิ่น, หรือเคล็ดลับการออกแบบได้เลย!"

if __name__ == "__main__":
    print(load_knowledge()['welcome'])
    print("\nพิมพ์ 'exit' เพื่อออกจากโปรแกรม")
    while True:
        user_input = input("\nคุณ: ")
        if user_input.lower() == 'exit':
            break
        response = get_response(user_input)
        print(f"\nAI: {response}")
