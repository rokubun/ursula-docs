FROM squidfunk/mkdocs-material as build

WORKDIR /docs

COPY requirements.txt requirements.txt

RUN pip install --requirement requirements.txt

COPY . .
RUN mkdocs build
EXPOSE 8000



FROM nginx:alpine
COPY --from=build /docs/site /usr/share/nginx/html