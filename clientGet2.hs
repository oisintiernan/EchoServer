import Network
import System.IO
import System.Environment (getArgs)

main = withSocketsDo $ do
    echo

echo :: IO ()
echo = do
    putStrLn "what word do you want in caps? Enter q to end program"
    input' <- getLine
    h <- connectTo "localhost" (PortNumber 8000)
    --h <- connectTo "www.scss.tcd.ie" (PortNumber 80)
    hSetBuffering h LineBuffering--means that each character wont consume a whole packet to itself
    hPutStr h ("GET /echo.php?message=" ++ input' ++ "\nHost: localhost:8000  \r\n\r\n")
    --hPutStr h ("GET /~ebarrett/lectures/cs4032/echo.php?message=" ++ input' ++ "\nHost: www.scss.tcd.ie  \r\n\r\n")
    --hPutStr h "GET /~ebarrett/lectures/cs4032/echo.php?message=" ++ input' ++ "HTTP/1.1\nHost: www.scss.tcd.ie  \r\n\r\n"
    contents <- hGetContents h
    putStrLn (contents)
    hClose h
    if (input' == "q")
        then return()
        else echo