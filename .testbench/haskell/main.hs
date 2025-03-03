data Lens s t = Lens { view :: s -> t, set :: t -> s -> s }

-- Example data type
data Person = Person { name :: String, age :: Int } deriving (Show)

-- Example lens for the 'name' field
nameLens :: Lens Person String
nameLens = Lens { view = name, set = \newName person -> person { name = newName } }

-- Using the lens
main :: IO ()
main = do
    let person = Person { name = "Alice", age = 30 }
    -- Viewing the name
    putStrLn $ "Name: " ++ view nameLens person
    -- Setting a new name
    let newPerson = set nameLens "Bob" person
    putStrLn $ "New Person: " ++ show newPerson
