﻿// <auto-generated />
using System;
using AboutUsers.Infrastructure.DataModel;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace AboutUsers.Infrastructure.Migrations
{
    [DbContext(typeof(AboutUserContext))]
    partial class AboutUserContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.9")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("AboutUsers.Domain.Users.Friend", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("EnumRoleOfUser")
                        .HasColumnType("int");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.Property<string>("UserName")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Friends");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.GroupOfUsers", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("GroupName")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("GroupOfUsers");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.Message", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int?>("FriendId")
                        .HasColumnType("int");

                    b.Property<int?>("GroupOfUsersId")
                        .HasColumnType("int");

                    b.Property<DateTime?>("Sending")
                        .HasColumnType("datetime2");

                    b.Property<string>("SendingBy")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Text")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("FriendId");

                    b.HasIndex("GroupOfUsersId");

                    b.ToTable("Messages");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("CreatedBy")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("UpdatedBy")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("UpdatedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("UserName")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("GroupOfUsersUser", b =>
                {
                    b.Property<int>("GroupOfUsersId")
                        .HasColumnType("int");

                    b.Property<int>("UsersId")
                        .HasColumnType("int");

                    b.HasKey("GroupOfUsersId", "UsersId");

                    b.HasIndex("UsersId");

                    b.ToTable("GroupOfUsersUser");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.Friend", b =>
                {
                    b.HasOne("AboutUsers.Domain.Users.User", null)
                        .WithMany("FriendlyUsers")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.Message", b =>
                {
                    b.HasOne("AboutUsers.Domain.Users.Friend", null)
                        .WithMany("messages")
                        .HasForeignKey("FriendId");

                    b.HasOne("AboutUsers.Domain.Users.GroupOfUsers", null)
                        .WithMany("Mesages")
                        .HasForeignKey("GroupOfUsersId");
                });

            modelBuilder.Entity("GroupOfUsersUser", b =>
                {
                    b.HasOne("AboutUsers.Domain.Users.GroupOfUsers", null)
                        .WithMany()
                        .HasForeignKey("GroupOfUsersId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("AboutUsers.Domain.Users.User", null)
                        .WithMany()
                        .HasForeignKey("UsersId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.Friend", b =>
                {
                    b.Navigation("messages");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.GroupOfUsers", b =>
                {
                    b.Navigation("Mesages");
                });

            modelBuilder.Entity("AboutUsers.Domain.Users.User", b =>
                {
                    b.Navigation("FriendlyUsers");
                });
#pragma warning restore 612, 618
        }
    }
}
