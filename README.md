# React App Docker Template

![GitHub License](https://img.shields.io/github/license/Aditya-Diva/Py-Project-Template?style=plastic)

![App](https://img.shields.io/badge/App-React-brightgreen)
![Container](https://img.shields.io/static/v1?label=Container&message=Docker&color=blue)
![Build](https://img.shields.io/badge/Build-Production-orange)

## Table of Contents

- [About the Project](#about-the-project)
- [Frameworks Used](#frameworks-used)
- [Usage](#usage)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
  - [To Develop](#to-develop)
  - [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About The Project

This is a sample template for react projects. Has been created for person reference and if this ends up helping you as well then that's great!

It involves some common commands and creating the bare bones setup. It's an attempt to create a standard for any react containers that I may end up using in other projects.

## Frameworks Used

- **[React](https://reactjs.org/)** for front-end applications
- **[Docker](https://www.docker.com/)** for containerization
- **[Nginx](https://www.nginx.com/)** for final deployment build

## Usage

### Installation

As a pre-requisite, please follow the installation steps from:
<https://docs.docker.com/engine/install/>

### Running the Application

Let's go through some steps to run the actual application

- Update [config.sh](config.sh). Here feel free to edit the image name and tag, container name. This will be used when building docker image and container on your local system.

- Go to [Dockerfile](Dockerfile). Here ensure that the lines ending with '# Comment during init' has been commented out. Then let's build and run the image,

  ```sh
  $ ./build.sh Dockerfile
  $ ./run.sh
  ```

Note that a folder called, 'app' would be created and mounted onto /home/node/app inside the container.

After executing [run.sh](run.sh), we will be dropped into the terminal of the container.

Confirm that the container has the right environment by running some test commands,

```sh
~/app $ whoami # This should give user as 'node'
~/app $ ls # Given that the app folder in the directory is empty(and folder's mounted), this shouldn't show any files
~/app $ echo $TESTING_ENV # should return "testing_env" as set in .env file
```

### To Develop

Now that we've understood how to setup the container, let's look at how to start developing,

Best practice would be to mount the folder app with the /home/node/app folder in the container. This way all development changes are saved locally and aren't reliant on the docker status.

Now we'd like to set up an application, here since we're not going to rename the folder 'app', we can use the following command to setup the default react app template in the current folder and enter 'y' to confirm.

```sh
~/app $ rm .gitkeep
~/app $ npx create-react-app .
Need to install the following packages:
  create-react-app
  Ok to proceed? (y)
```

In case, there's a need to create your own create app,

```sh
~/app $ npx create-react-app <my-app-name>

```

This will create a folder (named 'my-app-name') with files inside it.
Steps to use ARG in [Dockerfile](Dockerfile) to create custom folders has been hinted.

Once the app has been created,

```sh
~/app $ ls
README.md node_modules package-lock.json package.json public src
```

If app folder was mounted, we can see the same files and folders in app folder locally as well.

Now to start up the react server,

```sh
~/app $ npm start
# Local: http://localhost:3000
# On Your Network: http://172.17.0.2:3000
```

You can now view the default app in the browser. Feel free to use the address given for the network, on any device connected to it.

In order to keep developing, considering that the [app](app/) folder would have been populated with the app files/folders, build the image again, but this time remove the commented lines.

```Dockerfile
COPY --chown=node:node app/package*.json ./
...
RUN npm install
...
COPY --chown=node:node app ./
```

This will now copy the files/folders directly from the [app](app/) folder onto the docker image being built, so the steps wouldn't have to be repeated for the setup again.

### Deployment

If we decide to deploy the app, the steps are as mentioned below:

After following development steps above, and once development is satisfactory,

```
~/app $ npm run build
```

This will create a 'build' folder in the directory. These are the build files that would be required for deployment (usually involves optimization (cleaner and lighter) and conversion to binary executables.)

If there are no errors, the build folder is ready to be deployed. And the output would look similar to the following:

```sh
You may serve it with a static server:

npm install -g serve
serve -s build
```

> **Note:**
> npm install -g serve  
> Will set up the build folder in /usr/local/lib which would not be allowed as a non-root user (node). However, there's a better way to go about it.

Once we've confirmed the build can be done successfully,  
We shall now create the deployment build through a multi-stage Dockerfile,
After exiting the container,
Run the command below. Please not this will overwrite our development image, unless the [config.sh](config.sh) values are renamed specifically for deployment.

```sh
$ ./build.sh Dockerfile.dep
```

Once image has been built successfully, launch the deployment by running, (under the assumption image name/tag was not changed for deployment and left as default.)

```sh
docker run -d -p80:80 react-app-image-name:latest
```

Checkout the deployed site at [http://localhost:80](http://localhost:80) !

## Contributing

Any contributions made are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for more information.

## Contact

Aditya Divakaran - [@LinkedIn](https://www.linkedin.com/in/aditya-divakaran/) - [@Github](https://github.com/Aditya-Diva) - [@GMail](adi.develops@gmail.com)

Notes:

- This was tested on Ubuntu 22.04.
