#https://cloudstack.apache.org/api/apidocs-4.8/TOC_User.html List of all commands

#!/usr/bin/env python
# By: Kelcey Damage, 2012 & Kraig Amador, 2012
 
api_url = 'http://sfucloud.ca:8080/client/api'
apiKey = 'eLBogkpRt0W8tQ71eBe-ge5ppsxvFpxp6P5N5sP9D3NNCC8HJubsrvwsm_iaZIsLgpEA2MZkLnDdl0YvJ02rtw'
secret = 'fLi4QtiPKHRHZ7oSYkaQkoDehO7qNNVQqyFjhybIRl77vQa5iFrZHNNbeOZSAJjxhaNV5c3GiJZebUAWixHPXw'


OfferingID = '20216d24-ed60-4f26-879b-9bf32e7e5904'
TemplateID = '56da36c2-de54-4483-9d3c-3d3c7147615e' 
ZoneID = 'c687b45d-2822-43bc-a061-3399e92581d0'
 
import hashlib, hmac, string, base64, urllib
import json, urllib
 
class SignedAPICall(object):
    def __init__(self, api_url, apiKey, secret):
        self.api_url = api_url
        self.apiKey = apiKey
        self.secret = secret
 
    def request(self, args):
        args['apiKey'] = self.apiKey
 
        self.params = []
        self._sort_request(args)
        self._create_signature()
        self._build_post_request()
 
    def _sort_request(self, args):
        keys = sorted(args.keys())
 
        for key in keys:
            self.params.append(key + '=' + urllib.quote_plus(args[key]))
 
    def _create_signature(self):
        self.query = '&'.join(self.params)
        digest = hmac.new(
            self.secret,
            msg=self.query.lower(),
            digestmod=hashlib.sha1).digest()
 
        self.signature = base64.b64encode(digest)
 
    def _build_post_request(self):
        self.query += '&signature=' + urllib.quote_plus(self.signature)
        self.value = self.api_url + '?' + self.query
 
class CloudStack(SignedAPICall):
    def __getattr__(self, name):
        def handlerFunction(*args, **kwargs):
            if kwargs:
                return self._make_request(name, kwargs)
            return self._make_request(name, args[0])
        return handlerFunction
 
    def _http_get(self, url):
        response = urllib.urlopen(url)
        return response.read()
 
    def _make_request(self, command, args):
        args['response'] = 'json'
        args['command'] = command
        self.request(args)
        data = self._http_get(self.value)
        # The response is of the format {commandresponse: actual-data}
        key = command.lower() + "response"
        return json.loads(data)[key]
 
#Usage
 
api = CloudStack(api_url, apiKey, secret)

request = {'listall': 'true'}
result = api.listVirtualMachines(request)

counter=result.get("count")


for i in range(0,counter):
  print result.get("virtualmachine")[i].get("id")
  vm=result.get("virtualmachine")[i].get("id")
	
  targetVM = {'id' : result.get("virtualmachine")[i].get("id")}
  print targetVM
	
  if vm!="27543458-a83b-4c78-a694-8468181a22ca" and vm!="1ff6683e-71bc-4c84-8a1b-ac6b72b49ce5":
      print i
      result2= api.destroyVirtualMachine(targetVM)
	
	
#result = api.destroyVirtualMachine(targetVM)
