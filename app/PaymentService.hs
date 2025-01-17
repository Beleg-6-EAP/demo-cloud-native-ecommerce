{-# LANGUAGE DeriveAnyClass #-}

module PaymentService where

import Data.Aeson
import Data.UUID.V4 (nextRandom)
import Data.UUID (toString)
import GHC.Generics (Generic)

data OrderCreatedEvent = OrderCreatedEvent
  { oId     :: String
  , userId  :: String
  , amount  :: Double
  } deriving stock (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

data Payment = Payment
  { id        :: String
  , orderId   :: String
  , success   :: Bool
  } deriving stock (Show, Generic)
  deriving anyclass (FromJSON, ToJSON)

orderCreatedEventHandler :: OrderCreatedEvent -> IO ()
orderCreatedEventHandler event = do
  uId <- nextRandom
  let payment = Payment { id = toString uId, orderId = oId event, success = True }
  -- imagine here that payment always succeeds and we serialize it successfully
  -- imagine further serialization into e.g. Amazon RDS which would trigger a PaymentProcessedEvent
  print payment
  return ()
