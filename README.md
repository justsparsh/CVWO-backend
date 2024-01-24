# README

Ruby version: 3.2.2
Rails version: 7.1.2

I have deployed this project on Render and so if you want to take a look at the end-product, simply go to [https://dazzling-queijadas-b8cd49.netlify.app](https://dazzling-queijadas-b8cd49.netlify.app) (best experience on desktop and Google Chrome). However, since the backend is running on the free version of Render, the server gets spun down with inactivity. If the website is unresponsive at the beginning, you may have to wait a few minutes. If you want to run the webapp locally for a smoother experience, follow the steps below:

## Note: If you run the backend locally, you must run the frontend locally as well.

## Running locally
1. Fork this repo.
2. Clone your forked repo.
3. Ensure you have the right versions of ruby and rails installed
4. Open your terminal and navigate to the directory containing your cloned project.
5. Enter the command:
```bash
rails server
```
6. Follow the instructions on the frontend repo [(CVWO-frontend)](https://github.com/justsparsh/CVWO-frontend) to run it locally.
7. Important: Uncomment the local end-point at CVWO-frontend/src/data/API_URL.tsx when running the backend locally.
