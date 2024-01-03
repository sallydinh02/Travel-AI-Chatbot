# flask echo message + time sent
"""
from flask import Flask, jsonify,request
import time
app = Flask(__name__)
@app.route("/bot", methods=["POST"])
def response():
    #query = dict(request.form)['query']
    #res = query + " " + time.ctime()
    #return jsonify({"response" : res})
    d={}
    query=str(request.args['query'])
    res=str(query+" "+time.ctime())
    d['query']=res
    return d
if __name__=="__main__":
    app.run(host="0.0.0.0",)
"""

from flask import Flask, jsonify, request
import nltk

#nltk.set_proxy('http://0.0.0.0:10000')
nltk.download('punkt')
nltk.download('wordnet')

from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np

from keras.models import load_model
model = load_model('chatbot_model.h5')
import json
import random
intents = json.loads(open('intents.json', encoding='utf-8').read())
words = pickle.load(open('words.pkl','rb'))
classes = pickle.load(open('classes.pkl','rb'))


def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
    return sentence_words

# return bag of words array: 0 or 1 for each word in the bag that exists in the sentence

def bow(sentence, words, show_details=True):
    # tokenize the pattern
    sentence_words = clean_up_sentence(sentence)
    # bag of words - matrix of N words, vocabulary matrix
    bag = [0]*len(words)
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                # assign 1 if current word is in the vocabulary position
                bag[i] = 1
                if show_details:
                    print ("found in bag: %s" % w)
    return(np.array(bag))

def predict_class(sentence, model):
    # filter out predictions below a threshold
    p = bow(sentence, words, show_details=False)
    res = model.predict(np.array([p]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i,r] for i,r in enumerate(res) if r>ERROR_THRESHOLD]
    # sort by strength of probability
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    for r in results:
        return_list.append({"intent": classes[r[0]], "probability": str(r[1])})
    return return_list

def getResponse(ints, intents_json) -> str: 
    tag = ints[0]['intent']
    list_of_intents = intents_json['intents']
    for i in list_of_intents:
        if(i['tag']== tag):
            result: str = random.choice(i['responses'])
            break
        else:
            result: str = "You must ask the right questions"
    return result

def chatbot_response(msg):
    ints = predict_class(msg, model)
    res = getResponse(ints, intents)
    return res

#import processor
app = Flask(__name__)
@app.route('/bot', methods=["POST"])
def chatbotResponse():
    query = dict(request.form)['query']
    response = chatbot_response(query)   
    return jsonify({"response": str(response)})  
    #d={}
    #userMsg=str(request.args['query'])
    #response = str(processor.chatbot_response(userMsg))
    #d['response']=response
    #return d  

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000', debug=True)
