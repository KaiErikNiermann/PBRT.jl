{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
module Main where



main :: IO ()
main = do 
    let arr = map (*2) [1, 2, 3, 4] 
    print arr 
