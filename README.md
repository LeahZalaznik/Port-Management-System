# Port Management System

Welcome to the **Port Management System** project! This project is designed to manage port activities, including entries, exits, cargo unloading, and tool management.

## 🌟 Introduction

This system is designed to efficiently and securely manage the day-to-day operations of a port, including ship management, cargo handling, and tool usage. It includes procedures and triggers to ensure smooth port operations.

## 📋 Table Structure

- **Ships Table**: Contains the list of ships present in the port.
  - Columns: `BoatId`, `CargoId`, `BoatName`, `content`

- **Entry Table**: Records entries into the port.
  - Columns: `BoatId`, `dateTimeEntry`, `dateTimePass`

- **Exit Table**: Records exits from the port.
  - Columns: `BoatId`, `dateTimeExit`, `dateTimePass`

- **Cargo Table**: Details types of cargo.
  - Columns: `cargoId`, `cargoName`, `importance`

- **Tools Table**: Details the tools available in the port.
  - Columns: `toolId`, `toolName`, `amount`, `amountAvailable`

- **Unloading Tools for Each Cargo Table**: Describes the tools required for unloading.
  - Columns: `toolId`, `cargoId`, `amount`

- **Port Settings Table**: Details the capacity settings of the port.
  - Columns: `contentPort`, `contentPass`

## ⚙️ Core Processes

### Entry Procedure

1. **Check for Priority Ships**: Determines if there are ships waiting with more important cargo.
2. **Sort and Queue**: Sorts ships by cargo importance and prepares them for entry checks.
3. **Compatibility Check**: Verifies entry feasibility based on exit status, available tools, and port capacity.
4. **Update and Trigger**: Updates exit records and triggers tool update procedures.

### Tool Update Procedure

- Adjusts the count of available tools according to need.

### Unloading Completion Update Procedure

- Updates tool availability after cargo unloading.
- Marks unloading completion in records.

### Exit Procedure

- Confirms unloading completion before exit.
- Updates exit times and initiates entry for the next waiting ship.

## 🔄 Triggers

- **Entry Trigger**: Prevents entry if the ship is already in the queue.
- **Exit Trigger**: Blocks exit registration if the ship is already listed.

## 👁️ Views

- Displays detailed ship information: name, cargo type, docking frequency, last docking date, and average stay duration.

## 🖥️ System Requirements

- **SQL Server**: Compatible with MySQL, PostgreSQL, etc.
- **Database Management Tool**: Such as DBeaver, phpMyAdmin, etc.

## 🛠️ Installation

1. **Clone Repository**: Download the SQL files to your local workspace.
2. **Execute Scripts**: Run the provided SQL scripts on your database server.

## 🚀 Usage

- Apply procedures and triggers for regular port management tasks.
- Utilize views for comprehensive insights into ship activities.

## 🤝 Contribution

We welcome contributions! Feel free to submit issues or propose changes via pull requests.

## 📄 License

This project is licensed under the MIT License. For further details, refer to the [LICENSE](LICENSE) file.
