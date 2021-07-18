import React, { useContext, useState } from 'react';

export function Home() {
    const [integer, setInteger] = useState(100)
    const ThemeContext = React.createContext();

    const MyComponent = () => {
        const { integer, setInteger } = useContext(ThemeContext)

        return (
            <p>
                <p>Value: {integer}</p>
                <button onClick={() => setInteger(integer + 100)}>Increment</button>
            </p>
        )
    }

    const value = {
        integer,
        setInteger
    }

    return (
        <div>
            <h1>Context example</h1>
            <ThemeContext.Provider value={value}>
                <p><MyComponent /></p>
            </ThemeContext.Provider>
        </div>
    );
}