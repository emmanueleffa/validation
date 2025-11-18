print("Hello DevSecOps")


from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 5000

class Handler(SimpleHTTPRequestHandler):
    pass

with HTTPServer(("", PORT), Handler) as httpd:
    print(f"Server started at http://localhost:{PORT}")
    httpd.serve_forever()
