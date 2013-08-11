package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.jspxcms.core.domain.Admin;
import com.jspxcms.core.domain.Member;
import com.jspxcms.core.domain.Org;
import com.jspxcms.core.domain.User;
import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;

import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QUser is a Querydsl query type for User
 */

public class QUser extends EntityPathBase<User> {

    private static final long serialVersionUID = 719855465;

    private static final PathInits INITS = PathInits.DIRECT;

    public static final QUser user = new QUser("user");

    public final SetPath<Admin, QAdmin> admins = this.<Admin, QAdmin>createSet("admins", Admin.class, QAdmin.class, PathInits.DIRECT);

    public final DateTimePath<java.util.Date> creationDate = createDateTime("creationDate", java.util.Date.class);

    public final StringPath creationIp = createString("creationIp");

    public final StringPath email = createString("email");

    public final NumberPath<Integer> id = createNumber("id", Integer.class);

    public final DateTimePath<java.util.Date> lastLoginDate = createDateTime("lastLoginDate", java.util.Date.class);

    public final StringPath lastLoginIp = createString("lastLoginIp");

    public final NumberPath<Integer> logins = createNumber("logins", Integer.class);

    public final SetPath<Member, QMember> members = this.<Member, QMember>createSet("members", Member.class, QMember.class, PathInits.DIRECT);

    public final StringPath mobile = createString("mobile");

    public final QOrg org;

    public final SetPath<Org, QOrg> orgs = this.<Org, QOrg>createSet("orgs", Org.class, QOrg.class, PathInits.DIRECT);

    public final StringPath password = createString("password");

    public final DateTimePath<java.util.Date> prevLoginDate = createDateTime("prevLoginDate", java.util.Date.class);

    public final StringPath prevLoginIp = createString("prevLoginIp");

    public final StringPath realName = createString("realName");

    public final StringPath salt = createString("salt");

    public final StringPath username = createString("username");

    public QUser(String variable) {
        this(User.class, forVariable(variable), INITS);
    }

    @SuppressWarnings("all")
    public QUser(Path<? extends User> path) {
        this((Class)path.getType(), path.getMetadata(), path.getMetadata().isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QUser(PathMetadata<?> metadata) {
        this(metadata, metadata.isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QUser(PathMetadata<?> metadata, PathInits inits) {
        this(User.class, metadata, inits);
    }

    public QUser(Class<? extends User> type, PathMetadata<?> metadata, PathInits inits) {
        super(type, metadata, inits);
        this.org = inits.isInitialized("org") ? new QOrg(forProperty("org"), inits.get("org")) : null;
    }

}

