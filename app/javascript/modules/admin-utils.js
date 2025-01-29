
window.AdminUtils = {
    waitForVariable: (variableName, timeoutInSeconds, callback, obj = window) => {
        const startTime = new Date().getTime();
        const checkVariable = () => {
            if (obj[variableName] !== undefined) {
                callback();
            } else {
                const currentTime = new Date().getTime();
                if (currentTime - startTime < timeoutInSeconds * 1000) {
                    setTimeout(checkVariable, 100); // Check again after 100ms
                } else {
                    console.log(`${variableName} not defined within the specified timeout.`);
                }
            }
        };
        checkVariable();
    }
}