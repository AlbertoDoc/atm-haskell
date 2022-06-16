import Data.Void
import Text.Printf
import System.Directory

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
        showBankStatement
        showMenu
    | input == 3 = do
        deposit
        deleteAndRenameFile
        showMenu
    | input == 4 = do
        showMenu
    | input == 5 = putStrLn "Final do programa"

balance :: IO ()
balance = do
    let file = "balance.txt"
    putStr "Seu saldo é: "
    contents <- readFile file
    putStrLn contents

showBankStatement :: IO ()
showBankStatement = do
    let file = "bankStatement.txt"
    contents <- readFile file
    putStrLn contents
    putStrLn "Fim do extrato"
    putStrLn ""

deposit :: IO ()
deposit = do
    putStr "Insira o valor que deseja depositar: "
    valueToDeposit <- getLine

    let balanceFile = "balance.txt"
    balance <- readFile balanceFile

    let balanceFloat = read balance :: Float
    let valueToDepositFloat = read valueToDeposit :: Float


    let depositResult = balanceFloat + valueToDepositFloat
    let writeLine = printf "%.2f" depositResult

    let balanceFile2 = "balance2.txt"
    writeFile balanceFile2 writeLine

    let bankStatementFile = "bankStatement.txt"
    let writeLineBankStatement = printf "Deposito: %.2f\n" valueToDepositFloat
    appendFile bankStatementFile writeLineBankStatement

    putStrLn "Valor depositado com sucesso!"

deleteAndRenameFile :: IO ()
deleteAndRenameFile = do
    removeFile "balance.txt"
    renameFile "balance2.txt" "balance.txt"

main :: IO()
main = do
    putStrLn "Sistema de caixa automático"
    putStrLn "versão 0.1"
    
    putStrLn ""

    let balanceFile = "balance.txt"
    balanceFileExists <- doesFileExist balanceFile

    if not balanceFileExists
    then writeFile balanceFile "0.0" 
    else return ()

    let bankStatementFile = "bankStatement.txt"
    bankStatementFileExists <- doesFileExist bankStatementFile

    if not bankStatementFileExists
    then writeFile bankStatementFile ""
    else return ()
    
    showMenu
