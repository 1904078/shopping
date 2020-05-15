package com.shopping.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.shopping.entity.Product;
import com.shopping.entity.ShoppingRecord;
import com.shopping.service.ProductService;
import com.shopping.service.ShoppingRecordService;
import com.shopping.utils.Response;

/**
 * Created by 14437 on 2020/3/1.
 */
@Controller
public class ManagerController {
    @Resource
    private ProductService productService;

    @Resource
    private ShoppingRecordService shoppingRecordService;
    
    @RequestMapping(value = "/manager")
    public String manager() {
        return "manager";
    }

    @RequestMapping(value = "/manager/add")
    public String add() {
        return "managerAdd";
    }
    @RequestMapping(value = "/manager/img")
    public String img() {
        return "managerImg";
    }
    
    @RequestMapping(value = "/manager/getAllProducts")
    @ResponseBody
    public Map<String,Object> getAllProducts(){
        List<Product> productList = new ArrayList<>();
        productList = productService.getAllProduct();
        String allProducts = JSONArray.toJSONString(productList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("allProducts",allProducts);
        return resultMap;
    }

    @RequestMapping(value = "/manager/deleteProduct", method = RequestMethod.POST)
    @ResponseBody
    public Response deleteProduct(int id) {
        return productService.deleteProduct(id);
    }

    @RequestMapping(value = "/manager/addProduct", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addProduct(String name,String description,String keyWord,int price,int counts,int type) {
        System.out.println("Added item："+name);
        String result ="fail";
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setKeyWord(keyWord);
        product.setPrice(price);
        product.setCounts(counts);
        product.setType(type);
        productService.addProduct(product);
        result = "success";
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/manager/productDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> productDetail(int id, HttpSession httpSession) {
        System.out.println("I am here!"+id);
        Product product = productService.getProduct(id);
        httpSession.setAttribute("productDetail",product);
        System.out.print("I am here"+product.getName());
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/manager/product_detail")
    public String product_detail() {
        return "product_detail";
    }

    @RequestMapping(value = "/manager/searchPre", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> searchPre(String searchKeyWord,HttpSession httpSession) {
        httpSession.setAttribute("searchKeyWord",searchKeyWord);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/manager/search")
    public String search() {
        return "search";
    }

    @RequestMapping(value = "/manager/searchProduct", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> searchProduct(String searchKeyWord){
        System.out.println("SearchProduct"+searchKeyWord);
        List<Product> productList = new ArrayList<Product>();
        productList = productService.getProductsByKeyWord(searchKeyWord);
        String searchResult = JSONArray.toJSONString(productList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",searchResult);
        System.out.println("return"+searchResult);
        return resultMap;
    }

    @RequestMapping(value = "/manager/getProductById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getProductById(int id) {
        Product product = productService.getProduct(id);
        String result = JSON.toJSONString(product);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/manager/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam MultipartFile productImgUpload,
    		String name,String description,String keyWord,int price,int counts,int type, 
    		HttpServletRequest request) {
        String result = "fail";
        try{
             
            if(productImgUpload != null && !productImgUpload.isEmpty()) {
            	System.out.println("Added item："+name);
            	Product product = new Product();
            	product.setName(name);
            	product.setDescription(description);
            	product.setKeyWord(keyWord);
            	product.setPrice(price);
            	product.setCounts(counts);
            	product.setType(type);
            	
            	String fileNamePre = UUID.randomUUID().toString();
            	String fileName = fileNamePre+".jpg";
            	product.setImgname(fileName);
            	productService.addProduct(product);
            	
            	//int id = productService.getProduct(name).getId();
                String fileRealPath = request.getSession().getServletContext().getRealPath("/static/img");
                
                File fileFolder = new File(fileRealPath);
                System.out.println("fileRealPath=" + fileRealPath+"/"+fileName);
                if(!fileFolder.exists()){
                    fileFolder.mkdirs();
                }
                File file = new File(fileFolder,fileName);
                productImgUpload.transferTo(file);
                result = "Success！";
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }
    

    @RequestMapping(value = "/salelist")
    public String salelist() {
        return "salelist";
    }
    
    @RequestMapping(value = "/manager/getSaleList")
    @ResponseBody
    public Map<String,Object> getSaleList(){
    	List<ShoppingRecord> list = shoppingRecordService.getAllShoppingRecords();
        String allProducts = JSONArray.toJSONString(list);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("allProducts",allProducts);
        return resultMap;
    }

    @RequestMapping(value = "/salereport")
    public String salereport() {
        return "salereport";
    }
    
    @RequestMapping(value = "/manager/getReportData")
    @ResponseBody
    public Map<String,Object> getReportData(){
    	List<ShoppingRecord> rlist = shoppingRecordService.getAllShoppingRecords();
    	List<Product> plist = productService.getAllProduct();
    	Map<Integer, String> productMap = new HashMap<Integer, String>();
    	Map<String, Integer> p2rMap = new HashMap<String, Integer>();
    	for(Product p :plist) {
    		productMap.put(p.getId(), p.getName());
    		p2rMap.put(p.getName(), 0);
    	}
    	for(ShoppingRecord r : rlist) {
    		String name = productMap.get(r.getProductId());
    		p2rMap.put(name, p2rMap.get(name)+1);
    	}
        String allProducts = JSONArray.toJSONString(p2rMap);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("allProducts",allProducts);
        return resultMap;
    }
    
}
