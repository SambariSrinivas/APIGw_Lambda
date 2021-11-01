import json


def lambda_handler(event, context):
    print('Loading Lambda...')
    welcome_msg = 'Welcome to our demo API, here are the details of your request'
    print(welcome_msg)
    print(type(event))
    print(event)

    # parsing the request and extracting the required information

    content_type = event.get('headers', {}).get('content-type', 'n/a')
    #method = event.get('httpMethod')
    method = event['requestContext']['http']['method']
    print("Content-Type : ", content_type)
    print("Method :", method)

    # construct the headers section of response object
    headers = {'Content-Type': content_type}

    def app_response():
        if event.get('body') is not None:
            body = json.loads(event.get('body'))
            username = body.get('username', 'n/a')
            password = body.get('password', 'n/a')
            print("UserName : ", username)
            print("Password : ", password)
            # construct the body of the resposne object
            body = {'username': username, 'password': password}
            return body
        else:
            return None

    # return the response object
    if method == 'POST':

        # construct post response
        responseObject = {}
        responseObject['welcome message'] = welcome_msg
        responseObject['statuscode'] = 200
        responseObject['headers'] = headers
        responseObject['method'] = method
        responseObject['body'] = app_response()
        responseObject = json.dumps(responseObject)
        print(responseObject)
        return responseObject
    elif method == 'GET':
        responseObject = {}
        responseObject['welcome message'] = welcome_msg
        responseObject['statuscode'] = 200
        responseObject['headers'] = headers
        responseObject['method'] = method
        responseObject['body'] = app_response()
        responseObject = json.dumps(responseObject)
        print(responseObject)
        return responseObject
    else:
        return json.dumps('Invalid Request Method')
