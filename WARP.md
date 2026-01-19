# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is an educational repository for "Base de Datos 1" (Database 1) course IYA023 at Universidad Europea del Atlántico for the 2025-2026 academic year. It contains course materials, class notes, evaluations, and practical examples for teaching fundamental database concepts, particularly relational databases.

## Course Architecture

The course follows a structured progression from basic database concepts to practical implementation:

1. **Historical Context & Fundamentals** (Clase 1)
   - Database evolution from flat files to modern systems
   - Database types and models
   - DBMS introduction and Codd's rules

2. **Database Design Methodology** (Clase 2)
   - Design phases: requirements → conceptual → logical → physical
   - Entity-Relationship modeling (simple and extended)
   - Introduction to relational model

3. **Practical Applications**
   - Case studies: library management, employee/department systems, university enrollment
   - SQL queries and database normalization
   - DBMS architecture and optimization

## Common Development Tasks

### Viewing Course Materials
```bash
# View class objectives and structure
ls Clases/
cat "Clases/Clase 1/Objetivos.md"
cat "Clases/Clase 2/Objetivos.md"

# Read specific topics
find Clases/ -name "*.md" | grep -E "(historia|modelo|er|relacional)"
```

### Course Content Navigation
The repository structure mentioned in README.md references directories that may not yet exist:
- `temario/` - Course syllabus and topics
- `ejemplos/` - Modeling and SQL query examples  
- `casos-de-uso/` - Applied problems with modeling and scripts
- `evaluaciones/` - Continuous assessment activities
- `docs/` - Theoretical materials by topic

### Working with Database Examples
When examples and SQL scripts are added:
```bash
# Find SQL files
find . -name "*.sql" -type f

# Look for database modeling examples
find . -name "*modelo*" -o -name "*er*" -o -name "*relacional*"
```

## Course Evaluation Structure

- **Prácticas (Practices)**: 30%
- **Quices teóricos (Theoretical Quizzes)**: 20% 
- **Proyecto intermedio (Intermediate Project)**: 20%
- **Parcial (Midterm Exam)**: 30%

## Key Competencies Assessed

- Conceptual and logical modeling capacity
- Understanding of the relational model
- SQL querying skills
- DBMS architecture comprehension

## Content Organization

### Class Structure
Each class (`Clases/Clase N/`) contains:
- `Objetivos.md` - Learning objectives for the class
- Topic-specific markdown files (numbered sequentially)
- Theoretical content following the course progression

### Educational Focus Areas
1. **Database History** - Evolution from 1880s census processing to modern cloud databases
2. **Design Methodology** - Systematic approach to database design
3. **Entity-Relationship Modeling** - Both simple and extended ER models
4. **Relational Model** - Foundation of modern database systems
5. **Practical Implementation** - SQL and DBMS-specific implementations

## Working with Educational Content

When adding or modifying course materials:

1. **Follow the numbering system** used in class files (01_, 02_, etc.)
2. **Maintain the pedagogical sequence** - each topic builds on previous ones
3. **Include practical examples** relevant to the case studies mentioned (library, employees, university)
4. **Keep theoretical content accessible** for undergraduate computer science students
5. **Align with evaluation criteria** focusing on the four key competencies

## Repository Context

This is primarily a **content repository** rather than a code repository. When working with it:
- Focus on educational clarity and progression
- Maintain consistency with academic standards
- Ensure examples align with the relational database focus
- Consider the Spanish-speaking academic environment (Universidad Europea del Atlántico)

The repository serves as both teaching material and student reference, so maintain professional academic standards in all content additions or modifications.