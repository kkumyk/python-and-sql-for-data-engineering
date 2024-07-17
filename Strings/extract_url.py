'''
Write a function that when given a URL as a string, parses out just the domain name and returns it as a string.
* url = "http://github.com/carbonfive/raygun" -> domain name = "github"

- st.find(sub) - return the lowest index in the string where substring is found within the slice s[start:end]
the find method should only be used to find the position of the substring

'''

# def domain_name(url):  
#     return url.split("//")[-1].split("www.")[-1].split(".")[0]


def domain_name(url):
    url = url.replace('www.','')
    url = url.replace('https://','')
    url = url.replace('http://','')
    
    return url[0:url.find(".")]


print((domain_name("http://www.google.com/site"))) # "google"