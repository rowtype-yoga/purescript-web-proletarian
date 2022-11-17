module Yoga.WebBoss where

import Prelude

import Effect (Effect)
import Yoga.WebProletarian.Types (Worker)

foreign import onMessageFromWorker
  ∷ ∀ toBoss toWorker. (toBoss → Effect Unit) → Worker toBoss toWorker → Effect Unit

foreign import postMessageToWorker ∷ ∀ toBoss toWorker. toWorker → Worker toBoss toWorker → Effect Unit

foreign import terminate ∷ ∀ toBoss toWorker. Worker toBoss toWorker → Effect Unit
