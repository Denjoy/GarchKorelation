package com.garchkorelation.parsing;
import java.io.*;
import java.util.*;
import java.util.regex.*;
 
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
 
public class ParsUkrNafta {
 
    public static void main(String[] args) throws IOException {
 
        WebDriver driver = new FirefoxDriver();
        driver.navigate().to("http://investfunds.ua/markets/stocks/Ukrnafta/quotes/");
 
        List<WebElement> allInformation =  driver.findElements(By.xpath("//table/tbody/"));
        int i=0;
        String fileText = "";
 
        for (WebElement information : allInformation){
            String authorName = information.getText();
            String Url = (String)((JavascriptExecutor)driver).executeScript("return arguments[0].innerHTML;", allInformation.get(i++));
            final Pattern pattern = Pattern.compile("title=(.+?)>");
            final Matcher matcher = pattern.matcher(Url);
            matcher.find();
            String title = matcher.group(1);
            fileText = fileText+authorName+","+title+"\n";
        }
 
        Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("books.csv"), "utf-8"));
        writer.write(fileText);
        writer.close();
 
        driver.close();
    }
}