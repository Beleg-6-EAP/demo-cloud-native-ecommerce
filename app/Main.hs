module Main where

import AWS.Lambda.Runtime (ioRuntime)
import PaymentService

main :: IO ()
main = ioRuntime $ fmap Right . orderCreatedEventHandler
