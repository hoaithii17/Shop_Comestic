<table class="table table-bordered text-center">
    <thead class="table-dark">
        <tr>
            <th>S?n ph?m</th>
            <th>?ã bán</th>
            <th>Doanh thu</th>
            <th>Giá v?n</th>
            <th>L?i nhu?n</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="r" items="${reports}">
            <tr>
                <td>${r.productName}</td>
                <td>${r.sold}</td>
                <td class="text-success">${r.revenue}</td>
                <td class="text-warning">${r.cost}</td>
                <td class="${r.profit >= 0 ? 'text-success' : 'text-danger'}">
                    ${r.profit}
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
