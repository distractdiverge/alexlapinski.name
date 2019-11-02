module.exports = (event, context) => {
    return {
        responseCode: 200,
        body: {
            hello: 'world',
        },
    },
};