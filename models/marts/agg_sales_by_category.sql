select
    products.category,
    count(distinct sales.order_id) as total_orders,
    sum(sales.quantity) as total_units_sold,
    sum(sales.revenue) as total_revenue

from {{ ref('fct_sales') }} as sales

inner join {{ ref('dim_product') }} as products
    on sales.product_sk = products.product_sk

group by products.category
having sum(sales.quantity) > 0                          -- exclude categories without any sales