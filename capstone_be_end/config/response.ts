export default function response(statusCode: number, message: string, content: string, data: any) {
    return {
        statusCode: statusCode,
        message: message,
        content: content,
        DateTime: new Date(),
        data: data
    };
}
