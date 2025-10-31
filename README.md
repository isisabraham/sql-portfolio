# sql-portfolio

# SQL Portfolio – ContosoRetailDW (SQL Server)

**Summary:** This repo showcases SQL using ContosoRetailDW sample database. Projects include window functions, CTEs, `GROUPING SETS` reporting, reusable views, indexing, and before/after performance checks. 

---

## 📂 Projects
- 01 – Sales Analytics → KPI views (daily/monthly), rolling trends, territory rollups, indexing.
- 02 – Cohorts & Retention *(coming up)*
- 03 – RFM + CLV *(coming up)*
- 04 – A/B Testing in SQL *(coming up)*
- 07 – SCD2 with MERGE *(coming up)*
- 08 – Performance Tuning *(cross-cutting)*

> Order doesn’t matter; each project folder is self-contained.

---

## ⚙️ How to run

**EN**
1. Restore **ContosoRetailDW** on SQL Server (2019+).
2. Open a project folder and run `./sql` scripts in numeric order.
3. Some projects create **views**; others return **result sets** ready to export.
4. For tuning, enable `SET STATISTICS IO/TIME ON` and capture before/after metrics.

---

## 🧰 Stack
SQL Server 2019+ · SSMS / Azure Data Studio · ContosoRetailDW (star schema)

