import Network.HTTP
import Network.Stream
import Mail
import System.Environment
import Config

-- a simple test to see if the appserver is returning responses
isAppServerResponse :: String -> Result (Response t) -> Bool
isAppServerResponse _ (Left err) = False
isAppServerResponse criteria (Right r) = hasAppServer (rspHeaders r)
  where hasAppServer headers = any isAppServerHeader headers
        isAppServerHeader (Header HdrServer criteria) = True
        isAppServerHeader _ = False

-- a simple test to see if the response is probably a legit homepage
isLong :: [a] -> Bool
isLong xs = length xs > 1000

serverIsHealthy :: String -> String -> IO Bool
serverIsHealthy serverUrl headerCriteria = do
  let request = getRequest serverUrl
  response <- simpleHTTP request
  body <- getResponseBody response
  let lengthTest = isLong body
  let headerTest = isAppServerResponse headerCriteria response
  case [lengthTest, headerTest] of
    [True, True] -> return True
    otherwise -> return False

main = do
  args <- getArgs
  let configFile = args !! 0
  config <- fmap read $ readFile configFile
  healthy <- serverIsHealthy (serverUrl config) (serverHeaderCriteria config)
  case healthy of
    True -> return ()
    False -> do
      sendAlert config
      putStrLn "FAILURE"

