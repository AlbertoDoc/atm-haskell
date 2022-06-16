import Data.Void

showMenu :: IO ()
showMenu = do

    putStrLn "" 
    putStrLn "=============================="
    putStrLn "           Banco BAHIA"
    putStrLn "=============================="
    putStrLn "1. Saldo"
    putStrLn "2. Extrato"
    putStrLn "3. Depósito"
    putStrLn "4. Saque"
    putStrLn "5. Fim"

    input <- readLn
    handleMenu(input)

handleMenu :: Integer -> IO ()
handleMenu input
    | input == 1 = do 
        balance
        showMenu
    | input == 2 = do
        showMenu
    | input == 3 = do
        showMenu
    | input == 4 = do
        showMenu
    | input == 5 = putStrLn "Final do programa"

balance :: IO ()
balance = do
    let file = "balance.txt"
    putStr "Seu saldo eh: "
    contents <- readFile file
    putStrLn contents

main :: IO()
main = do
    putStrLn "Sistema de caixa automático"
    putStrLn "versão 0.1"
    
    putStrLn ""

    let balanceFile = "balance.txt"
    writeFile balanceFile "0.0"
    let bankStatementFile = "bankStatement.txt"
    showMenu
