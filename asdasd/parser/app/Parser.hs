module Parser where

import Text.Parsec
import Text.Parsec.String (Parser)

number :: Parser Int
number = do
    n <- many1 digit
    return (read n)

operator :: Parser (Int -> Int -> Int)
operator = (char '+' >> return (+))
       <|> (char '-' >> return (-))
       <|> (char '*' >> return (*))
       <|> (char '/' >> return div)

-- A term is a number or a parenthesized expression
term :: Parser Int
term = number
    <|> between (char '(') (char ')') expr

-- Parse factors (multiplication and division)
factor :: Parser Int
factor = chainl1 term mulop

-- Multiplication and division operators
mulop :: Parser (Int -> Int -> Int)
mulop = (char '*' >> return (*))
    <|> (char '/' >> return div)

-- Parse expressions (addition and subtraction)
expr :: Parser Int
expr = chainl1 factor addop

-- Addition and subtraction operators
addop :: Parser (Int -> Int -> Int)
addop = (char '+' >> return (+))
    <|> (char '-' >> return (-))

parseExpr :: String -> Either ParseError Int
parseExpr = parse (expr <* eof) ""
