from http.client import HTTPResponse
from pydoc import HTMLRepr
from django.shortcuts import render, HttpResponse, redirect
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
# def index(request):
#     return HTTPResponse('Welcome!')

# import random
# def index(request):
#     return HttpResponse('<h1>Random</h1>' + str(random.random()))
nextId = 4
topics = [
    {'id': 1, "title": "Routing", "body": "Routing is..."},
    {'id': 2, "title": "View", "body": "View is..."},
    {'id': 3, "title": "Model", "body": "Model is..."}
]

# HttpResponse에는 HTML 태그가 전달되어서 HTML 기반 페이지를 생성하는 것임 

# 반복되는 동작을 함수로 구현 
def HTMLTemplate(articleTag, id = None):
    global topics
    contextUI = ''
    # topics를 li 태그와 연결을 시키는 것 
    if id != None:
        contextUI = f'''
            <li>
                <form action = "/delete/" method = "post">
                    <input type = "hidden" name = "id" value = {id}>
                    <input type = "submit" value = "delete">
                </form>
            </li> 
            <li><a href = "/update/{id}">update</a></li>
        '''
    ol = ''
    for topic in topics:
        ol += f'<li><a href ="/read/{topic["id"]}">{topic["title"]}</a></li>'

    return f'''
    <html>
    <body>
        <h1><a href = "/">Django</a></h1>
        <ol>
            {ol}
        </ol>
        
        {articleTag}

        <ul>
            <li><a href = "/create">create</a></li>
            {contextUI}
            <!--서버의 데이터를 변경/수정하는 경우에는 link, get을 사용하면 안되고 POST를 써야함,,, form -->
        </ul>
    </body>
    </html>
    '''


def index(request):
    article = '''        
    <h2>Welcome</h2>
    Hello, Django
    '''
    return HttpResponse(HTMLTemplate(article))

def read(request, id):
    global topics

    article = ""
    for topic in topics: 
        if topic["id"] == int(id):
            article = f'<h2>{topic["title"]}</h2>{topic["body"]}'
    # return HttpResponse("Read!" + id)
    return HttpResponse(HTMLTemplate(article, id))


@csrf_exempt
def create(request):
    # name은 title이란 이름으로 데이터를 전송을 하도록 
    # placeholder는 사용자가 읽을 수 있게 
    # textarea는 여러 줄의 입력을 받을 때 
    # action은 submit을 했을 때 보낼 서버 
    # method 태그로 query의 방식을 결정함 
    # form action은 기본적으로 GET임 
    
    
    # print("request.method", request.method)
    global nextId
    
    if request.method == "GET":
        article = '''
        <form action = "/create/" method = "post">
            <p><input type = "text" name = "title" placeholder = "title"></p>
            <p><textarea name = "body" placeholder = "body"></textarea></p>
            <p><input type = "submit"></p>
        </form>
        '''
        return HttpResponse(HTMLTemplate(article))
    elif request.method == "POST":
        title = request.POST["title"]
        body = request.POST["body"]
        
        newTopic = {"id": nextId, "title": title, "body": body}
        topics.append(newTopic)
        url = "/read/" + str(nextId)
        nextId = nextId + 1
        
        return redirect(url)

@csrf_exempt
def delete(request):
    global topics
    if request.method == "POST":
        id = request.POST["id"]
        newTopics = []
        for topic in topics:
            if topic['id'] != int(id):
                newTopics.append(topic)
        topics = newTopics
        return redirect('/')

@csrf_exempt
def update(request, id):
    global topics
    if request.method == "GET":
        for topic in topics:
            if topic["id"] == int(id):
                selectedTopic = {
                    "title": topic["title"],
                    "body": topic["body"]
                }
        article = f'''
        <form action = "/update/{id}/" method = "post">
            <p><input type = "text" name = "title" placeholder = "title" value = {selectedTopic["title"]}></p>
            <p><textarea name = "body" placeholder = "body">{selectedTopic["body"]}</textarea></p>
            <p><input type = "submit"></p>
        </form>
        '''
        return HttpResponse(HTMLTemplate(article, id))
    elif request.method == "POST":
        title = request.POST["title"]
        body = request.POST["body"]
        for topic in topics:
            if topic["id"] == int(id):
                topic["title"] = title
                topic["body"] = body
        return redirect(f"/read/{id}")

# query string! 
# http://localhost:8000/read/?id=1&mode=....