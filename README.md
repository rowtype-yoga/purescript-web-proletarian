# 🐝 Web Proletarian

This library provides a way to define and interact with webworkers.

This means you need to bundle your app with a bundler that understands the
`new Worker(new URL("someWorker.js", import.meta.url))` syntax (e.g. webpack5, vite, ...).

Maybe it also works without bundling in some browsers with es modules, but I don't know.


## How To

### Write the WebWorker in PureScript
To write a webworker you use the module `Yoga.WebProletarian.WebWorker`.
E.g.:

```purs
module Worker.Echo where

import Prelude

import Effect (Effect)
import Yoga.WebProletarian.Types (Worker)
import Yoga.WebWorker (postMessageToBoss, subscribe)

main ∷ Effect Unit
main = subscribe (\(i :: Int) -> postMessageToBoss (show i))

foreign import newWorker ∷ Effect (Worker Int String)
```

### Write a correspoding FFI file with the import
With an FFI file that your bundler understands:
```js
export const newWorker = () => new Worker(new URL("../../workers/echo.worker.js", import.meta.url))
```

Bundlers look for this kind of syntax at build time, so I couldn't find a way to 
emit PureScript code that causes them to pick this up.
I guess the number of workers you'll have is limited anyway so I can personally live with the FFI.

### Build your webworker

This means you should have the bundled version of this worker in: `/workers/echo.worker.js`

You can achieve this with spago by telling it to use your worker module as the Main method:

```sh
spago bundle-app -m Worker.Echo --to /workers/echo.worker.js
```

Then in your regular application you can interact with the Worker in the following way:

### Interact with the webworker

```purs
module Main where

import Prelude

import Effect (Effect)
import Yoga.WebProletarian.Types (Worker)
import Yoga.WebBoss (postMessageToWorker, onMessageFromWorker, terminate)
import Worker.Echo as Echo

main :: Effect Unit
main = do
  worker ← Echo.newWorker
  worker # onMessageFromWorker \msg -> do 
    Console.log msg
    worker # terminate
  worker # postMessageToWorker 42
```

### Bundle it up and have fun
