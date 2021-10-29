export function doGet() {
    return HtmlService.createTemplateFromFile("index")
        .evaluate()
        .setTitle("title");
}
export function include(filename) {
    return HtmlService.createHtmlOutputFromFile(filename).getContent();
}
