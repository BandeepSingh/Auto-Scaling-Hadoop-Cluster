#https://cloudstack.apache.org/api/apidocs-4.8/TOC_User.html List of all commands

#!/usr/bin/env python
# By: Kelcey Damage, 2012 & Kraig Amador, 2012
 
api_url = 'http://sfucloud.ca:8080/client/api'
apiKey = 'eLBogkpRt0W8tQ71eBe-ge5ppsxvFpxp6P5N5sP9D3NNCC8HJubsrvwsm_iaZIsLgpEA2MZkLnDdl0YvJ02rtw'
secret = 'fLi4QtiPKHRHZ7oSYkaQkoDehO7qNNVQqyFjhybIRl77vQa5iFrZHNNbeOZSAJjxhaNV5c3GiJZebUAWixHPXw'


OfferingID = '20216d24-ed60-4f26-879b-9bf32e7e5904'
TemplateID = 'c70812d9-34e6-40c2-8c21-935669392631' 
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

print
request =  {'serviceofferingid': OfferingID,'templateid':TemplateID,'zoneid':ZoneID}
result = api.deployVirtualMachine(request)
print result
print

targetVM = {'id' : result.get("id")}
request = targetVM

#filename = raw_input("Press Enter To delete VM")
#result = api.destroyVirtualMachine(targetVM)
