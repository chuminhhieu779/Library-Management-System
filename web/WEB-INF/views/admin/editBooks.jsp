<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://jakarta.ee/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/style.css">

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f3f4f6;
            padding: 40px;
        }
        .edit-container {
            background: #fff;
            border-radius: 10px;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: 600;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
        }
        .btn {
            display: inline-block;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-size: 15px;
            cursor: pointer;
        }
        .btn:hover {
            background: #1d4ed8;
        }
        .img-preview {
            display: block;
            width: 120px;
            height: auto;
            border-radius: 6px;
            margin-top: 8px;
        }
    </style>
</head>
<body>

<div class="edit-container">
    <h2>Edit Book Information</h2>

    <form action="${pageContext.request.contextPath}/admin/books/edit" 
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="bookID" value="${book.bookID}">

        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" value="${book.title}" required>
        </div>

        <div class="form-group">
            <label for="author">Author</label>
            <input type="text" id="author" name="author" value="${book.author}" required>
        </div>

        <div class="form-group">
            <label for="quantity">Quantity</label>
            <input type="number" id="quantity" name="quantity" value="${book.quantity}" min="0">
        </div>

        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="categoryID" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryID}" 
                        ${book.category.categoryID == cat.categoryID ? 'selected' : ''}>
                        ${cat.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="coverImage">Cover Image</label>
            <input type="file" id="coverImage" name="coverImage" accept="image/*">
            <c:if test="${not empty book.coverImage}">
                <img class="img-preview"
                     src="${pageContext.request.contextPath}/resources/images/${book.coverImage}"
                     alt="Book Cover">
            </c:if>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4">${book.description}</textarea>
        </div>

        <div style="text-align:center;">
            <button type="submit" class="btn"><i class="fa-solid fa-save"></i> Save Changes</button>
        </div>
    </form>
</div>

</body>
</html>
