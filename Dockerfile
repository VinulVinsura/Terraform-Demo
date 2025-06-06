# Build Angular app
FROM node:20 AS builder

# set directory in our docker envi
WORKDIR /app


# copy package. json file in our app directory
COPY package*.json ./

# downlode the node_modules
RUN npm install

COPY . .
# build dist folder
RUN npm run build


# set up serve app in our docker env
FROM nginx:1.25-alpine

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy compiled Angular app from builder
COPY --from=builder /app/dist/sample-app/browser /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]





